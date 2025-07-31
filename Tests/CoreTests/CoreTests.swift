import Testing
import OneEntryCore
import OneEntryShared

struct CoreTests {
    init() async throws {
        OneEntryApp.shared.initialize(
            host: "hummel-mobile.oneentry.cloud",
            token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiS290bGluIE11bHRpcGxhdGZvcm0iLCJzZXJpYWxOdW1iZXIiOjMsImlhdCI6MTczNTMyMjQ2NywiZXhwIjoxNzY2ODU4NDQ4fQ.3YZHZ39povhcmUpUAgMiD5b4NuZ9zK5ThObVYqkmvuk"
        ) {
            LogLevel(.all)
        }
    }
    
    @Test
    func test404() async throws {
        do {
            try await print(SystemService.shared.test404())
        } catch let error as NSError {
            let exception = try #require(error.kotlinException as? OneEntryException.NotFoundException)
            
            #expect(exception.statusCode == 404)
        }
    }
    
    @Test
    func test500() async throws {
        do {
            try await print(SystemService.shared.test500())
        } catch let error as NSError {
            let exception = try #require(error.kotlinException as? OneEntryException.InternalServerException)
            
            #expect(exception.statusCode == 500)
        }
    }
}
