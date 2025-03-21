//
//  Page+Localized.swift
//  OneEntry
//
//  Created by Archibbald on 12/3/24.
//

import Foundation
import OneEntryShared
import OneEntryAttribute
import OneEntryLocalized

extension Page: Localizable {
    public var content: LocalizedContent {
        LocalizedContent(attributes: .init(collection: attributeValues))
    }
}
