//
//  FilterProductBuilder.swift
//  OneEntry
//
//  Created by Archibbald on 12/17/24.
//

import Foundation

@preconcurrency import OneEntryShared

public struct ConditionBlock: Sendable {
    let builder: OneEntryShared.FilterProductBuilder
    
    public init(
        attributeMarker: String? = nil,
        conditionMarker: ConditionMarker? = nil,
        statusMarker: String? = nil,
        conditionValue: AttributeValue? = nil,
        pageUrls: [String]? = nil,
        title: String? = nil,
        isNested: Bool? = nil
    ) {
        let builder = OneEntryShared.FilterProductBuilder()
        builder.attributeMarker = attributeMarker
        builder.conditionMarker = conditionMarker
        builder.statusMarker = statusMarker
        builder.conditionValue = conditionValue
        builder.conditionValue = conditionValue
        builder.pageUrls = pageUrls
        builder.title = title
        builder.isNested = isNested.map { .init(bool: $0) }
        
        self.builder = builder
    }
}
