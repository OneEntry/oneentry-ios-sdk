//
//  LocalizedAttributeCollection.swift
//  OneEntry
//
//  Created by Archibbald on 30.06.2024.
//  Copyright © 2024 OneEntry. All rights reserved.
//

import Foundation

import OneEntryCore
import OneEntryShared

@dynamicMemberLookup
public struct LocalizedAttributeCollection: LocalizableCollection {
    public typealias CollectionType = [String : AttributeCollection ]
    
    public var collection: CollectionType = [:]
    
    public init(collection: CollectionType) {
        self.collection = collection
    }
    
    public init(collection: [String : [String : AttributeValue]]) {
        self.collection = collection.mapValues { .init(collection: $0) }
    }
    
    public init() { }
    
    public subscript(dynamicMember member: String) -> CollectionType.Value {
        collection[member, default: .init()]
    }
    
    public subscript(locale: String) -> CollectionType.Value {
        self[dynamicMember: locale]
    }
}
