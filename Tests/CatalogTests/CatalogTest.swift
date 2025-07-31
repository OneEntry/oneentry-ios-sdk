//
//  Test.swift
//  OneEntry
//
//  Created by Archibbald on 12/17/24.
//

import Testing

import OneEntryShared
import OneEntryCatalog
import OneEntryCore
import OneEntryPages

struct CatalogTest {
    init() async throws {
        OneEntryApp.shared.initialize(
            host: "hummel-mobile.oneentry.cloud",
            token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiS290bGluIE11bHRpcGxhdGZvcm0iLCJzZXJpYWxOdW1iZXIiOjMsImlhdCI6MTczNTMyMjQ2NywiZXhwIjoxNzY2ODU4NDQ4fQ.3YZHZ39povhcmUpUAgMiD5b4NuZ9zK5ThObVYqkmvuk"
        ) {
            LogLevel(.all)
        }
    }
    
    @Test
    func all() async throws {
        let result = try await CatalogService.shared.all {
            ConditionBlock(
                attributeMarker: "price",
                conditionMarker: .greaterThen,
                conditionValue: .init(double: 10.0)
            )
        }
        
        for item in result.items() {
            let price = try #require(item.price?.doubleValue)
            
            #expect(price > 10.0)
        }
    }
    
    @Test
    func byPageWithID() async throws {
        let page = try await PagesService.shared.page(url: "dev", langCode: "en_US")
        let result = try await CatalogService.shared.byPage(id: .init(page.id)) {
            ConditionBlock(
                attributeMarker: "price",
                conditionMarker: .greaterThen,
                conditionValue: .init(double: 10.0)
            )
        }
        
        for item in result.items() {
            let price = try #require(item.price?.doubleValue)
            
            #expect(price > 10.0)
        }
    }
    
    @Test
    func byPageWithURL() async throws {
        let result = try await CatalogService.shared.byPage(url: "dev") {
            ConditionBlock(
                attributeMarker: "price",
                conditionMarker: .greaterThen,
                conditionValue: .init(double: 10.0)
            )
        }
        
        for item in result.items() {
            let price = try #require(item.price?.doubleValue)
            
            #expect(price > 10.0)
        }
    }
}
