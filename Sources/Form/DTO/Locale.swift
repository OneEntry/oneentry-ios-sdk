//
//  Locale.swift
//  OneEntry
//
//  Created by Archibbald on 12/24/24.
//

import Foundation

@preconcurrency import OneEntryShared
import OneEntryCore

public struct Locale: Sendable {
    public var langCode: String
    public var data: [Form.Data]
    
    public init(_ langCode: String, @DSLBuilder<FormData> perform data: () -> [FormData]) {
        self.langCode = langCode
        self.data = data().map(\.data)
    }
}
