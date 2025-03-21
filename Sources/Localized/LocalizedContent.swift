//
//  LocalizedContent.swift
//  OneEntry
//
//  Created by Archibbald on 12/3/24.
//

import Foundation
import OneEntryAttribute

public struct LocalizedContent {
    public var attributes: LocalizedAttributeCollection
    
    public init(attributes: LocalizedAttributeCollection) {
        self.attributes = attributes
    }
}

public protocol Localizable {
    var content: LocalizedContent { get }
}
