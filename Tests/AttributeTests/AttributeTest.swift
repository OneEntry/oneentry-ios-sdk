//
//  AttributeTest.swift
//  OneEntry
//
//  Created by Archibbald on 12/3/24.
//

import Testing

import OneEntryCore
import OneEntryPages
import OneEntryShared

struct AttributeTest {
    let page: Page
    
    let locale = "en_US"
    
    init() async throws {
        OneEntryApp.shared.initialize(
            host: "hummel-mobile.oneentry.cloud",
            token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiS290bGluIE11bHRpcGxhdGZvcm0iLCJzZXJpYWxOdW1iZXIiOjMsImlhdCI6MTczNTMyMjQ2NywiZXhwIjoxNzY2ODU4NDQ4fQ.3YZHZ39povhcmUpUAgMiD5b4NuZ9zK5ThObVYqkmvuk"
        ) {
            LogLevel(.all)
        }
        
        self.page = try await PagesService.shared.page(url: "dev", langCode: locale)
    }

    @Test
    func regular() async throws {
        let attributes = try #require(page.attributeValues[locale])
        let attribute = try #require(attributes["string"])
        
        try #expect(attribute.valueAsString() == "String")
    }
    
    @Test
    func dsl() async throws {
        let attributes = try #require(page.content.attributes[locale])
        let attribute = try #require(attributes.string)
        
        try #expect(attribute.valueAsString() == "String")
    }
}
