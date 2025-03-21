//
//  Attribute.swift
//  OneEntry
//
//  Created by Archibbald on 1/6/25.
//

import Foundation

@preconcurrency import OneEntryShared

@dynamicMemberLookup
public enum Attribute: Sendable {
    public typealias General = __Attribute.General
    public typealias List = __Attribute.List
    public typealias Entity = __Attribute.Entity
    
    case general(general: General)
    case list(list: List)
    case entity(entity: Entity)
    
    public subscript<Value>(dynamicMember keyPath: KeyPath<__Attribute, Value>) -> Value {
        let attribute: __Attribute = switch self {
            case .general(let attribute): attribute
            case .list(let attribute): attribute
            case .entity(let attribute): attribute
        }
        
        return attribute[keyPath: keyPath]
    }
}

extension Attribute {
    init(from attribute: __Attribute) {
        self = if let attribute = attribute as? List {
            .list(list: attribute)
        } else if let attribute = attribute as? Entity {
            .entity(entity: attribute)
        } else {
            .general(general: attribute as! General)
        }
    }
}
