//
//  AttributeValue+Init.swift.swift
//  OneEntry
//
//  Created by Archibbald on 3/18/25.
//

import Foundation

import OneEntryShared

public extension AttributeValue {
    convenience init(string: String) {
        let attribute = AttributeValue.companion.fromString(value: string)
        
        self.init(type: attribute.type, value: attribute.value)
    }

    convenience init(double: Double) {
        let attribute = AttributeValue.companion.fromDouble(value: double)
        self.init(type: attribute.type, value: attribute.value)
    }

    convenience init(int: Int) {
        let attribute = AttributeValue.companion.fromInt(value: Int32(int))
        self.init(type: attribute.type, value: attribute.value)
    }

    convenience init(images: [Image]) {
        let attribute = AttributeValue.companion.fromImages(value: images)
        self.init(type: attribute.type, value: attribute.value)
    }

    convenience init(texts: [Text]) {
        let attribute = AttributeValue.companion.fromTexts(value: texts)
        self.init(type: attribute.type, value: attribute.value)
    }

    convenience init(rows: [ListRow]) {
        let attribute = AttributeValue.companion.fromRows(value: rows)
        self.init(type: attribute.type, value: attribute.value)
    }

    convenience init(row: ListRow) {
        let attribute = AttributeValue.companion.fromRow(value: row)
        self.init(type: attribute.type, value: attribute.value)
    }
}
