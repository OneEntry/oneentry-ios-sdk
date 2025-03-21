//
//  FormServiceTests.swift
//  OneEntry
//
//  Created by Archibbald on 12/24/24.
//

import Testing

import OneEntryAttribute
import OneEntryShared
import OneEntryForm

struct FormServiceTests {
    init() async throws {
        OneEntryCore.shared.initialize(
            host: "hummel-mobile.oneentry.cloud",
            token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiS290bGluIE11bHRpcGxhdGZvcm0iLCJzZXJpYWxOdW1iZXIiOjMsImlhdCI6MTczNTMyMjQ2NywiZXhwIjoxNzY2ODU4NDQ4fQ.3YZHZ39povhcmUpUAgMiD5b4NuZ9zK5ThObVYqkmvuk"
        )
    }
    
    @Test
    func sendData() async throws {                
        let home = "home"
        let comment = "comment"
        
        let entity = try await FormsService.shared.sendData(formIdentifier: "delivery") {
            Locale("en_US") {
                FormData(marker: "address", attribute: .init(string: home))
                FormData(marker: "comment", attribute: .init(string: comment))
                FormData(marker: "entrance", attribute: .init(int: 1))
            }
        }
        
        let resultHome = try #require(
            try? entity.formData.formData["en_US"]?
                .first { $0.marker == "address" }?
                .valueAsString()
        )
        
        let resultComment = try #require(
            try? entity.formData.formData["en_US"]?
                .first { $0.marker == "comment" }?
                .valueAsString()
        )
        
        #expect(resultHome == home)
        #expect(resultComment == comment)
    }
}
