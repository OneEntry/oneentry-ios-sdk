//
//  AttributeCollection.swift
//  OneEntry
//
//  Created by Archibbald on 01.07.2024.
//  Copyright © 2024 OneEntry. All rights reserved.
//

import Foundation
import OneEntryCore
@preconcurrency import OneEntryShared

@dynamicMemberLookup
public struct AttributeCollection: LocalizableCollection {
    public typealias CollectionType = [String : AttributeValue]
    
    public var collection: CollectionType = [:]
    
    public init(collection: CollectionType) {
        self.collection = collection
    }
    
    public init() { }
    
    public subscript(dynamicMember member: String) -> CollectionType.Value? {
        collection[member]
    }
}
