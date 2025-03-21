//
//  LocalizedCollection.swift
//  OneEntry
//
//  Created by Archibbald on 01.07.2024.
//  Copyright © 2024 OneEntry. All rights reserved.
//

import Foundation

public protocol LocalizableCollection: Collection, Sendable {
    associatedtype CollectionType: Collection & Sendable
    
    var collection: CollectionType { get set }
    
    init(collection: CollectionType)
}

extension LocalizableCollection {
    public var startIndex: CollectionType.Index { collection.startIndex }
    public var endIndex: CollectionType.Index { collection.endIndex }
    
    public subscript(position: CollectionType.Index) -> CollectionType.Element {
        collection[position]
    }
    
    public func index(after i: CollectionType.Index) -> CollectionType.Index {
        collection.index(after: i)
    }
}
