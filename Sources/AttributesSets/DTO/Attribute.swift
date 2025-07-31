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
    public typealias General = __AttributeGeneral
    public typealias List = __AttributeList
    public typealias Entity = __AttributeEntity
    public typealias TimeInterval = __AttributeTimeInterval
    
    case general(general: General)
    case list(list: List)
    case entity(entity: Entity)
    case timeInterval(interval: TimeInterval)
    
    public subscript<Value>(dynamicMember keyPath: KeyPath<__Attribute, Value>) -> Value {
        let attribute: __Attribute = switch self {
            case .general(let attribute): attribute
            case .list(let attribute): attribute
            case .entity(let attribute): attribute
            case .timeInterval(let attribute): attribute
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
        } else if let attribute = attribute as? General {
            .general(general: attribute)
        } else {
            .timeInterval(interval: attribute as! TimeInterval)
        }
    }
}
