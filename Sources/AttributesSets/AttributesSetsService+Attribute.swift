//
//  AttributesSetsService+Attribute.swift
//  OneEntry
//
//  Created by Archibbald on 1/6/25.
//

import Foundation

import OneEntryShared

public extension AttributesSetsService {
    func attributes(
        marker: String,
        langCode: String = "en_US"
    ) async throws -> [Attribute] {
        let attributes = try await __attributes(marker: marker, langCode: langCode)
        
        return attributes.compactMap { Attribute(from: $0) }
    }
    
    func attribute(
        setMarker: String,
        attributeMarker: String,
        langCode: String = "en_US"
    ) async throws -> Attribute {
        try await Attribute(from: __attributes(setMarker: setMarker, attributeMarker: attributeMarker, langCode: langCode))
    }
}
