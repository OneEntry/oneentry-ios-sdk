//
//  OneEntryAttributesSetsTests.swift
//  OneEntry
//
//  Created by Archibbald on 1/6/25.
//

import Testing

import OneEntryCore
import OneEntryShared
import OneEntryAttributesSets

struct OneEntryAttributesSetsTests {
    init() async throws {
        OneEntryApp.shared.initialize(
            host: "hummel-mobile.oneentry.cloud",
            token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiS290bGluIE11bHRpcGxhdGZvcm0iLCJzZXJpYWxOdW1iZXIiOjMsImlhdCI6MTczNTMyMjQ2NywiZXhwIjoxNzY2ODU4NDQ4fQ.3YZHZ39povhcmUpUAgMiD5b4NuZ9zK5ThObVYqkmvuk"
        ) {
            LogLevel(.all)
        }
    }
    
    @Test
    func attributes() async throws {
        let attributes = try await AttributesSetsService.shared.attributes(marker: "all")
        
        var general: Attribute.General? = nil
        var list: Attribute.List? = nil
        var entity: Attribute.Entity? = nil
        var interval: Attribute.TimeInterval? = nil
        
        for attribute in attributes {
            switch attribute {
                case .general(let attribute):
                    general = attribute
                case .list(let attribute):
                    list = attribute
                case .entity(let attribute):
                    entity = attribute
                case .timeInterval(let attribute):
                    interval = attribute
            }
        }
        
        #expect(general != nil)
        #expect(list != nil)
        #expect(entity != nil)
        #expect(interval != nil)
    }
    
    @Test
    func singleAttribute() async throws {
        let attribute = try await AttributesSetsService.shared.attribute(setMarker: "all", attributeMarker: "list")
        
        guard case .list(let list) = attribute else { Issue.record("A list type attribute was expected"); return }

        #expect(attribute.marker == list.marker)
        #expect(!list.listTitles.isEmpty)
    }
}
