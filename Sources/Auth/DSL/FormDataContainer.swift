//
//  FormDataContainer.swift
//  OneEntry
//
//  Created by Archibbald on 12/25/24.
//

import Foundation

@preconcurrency import OneEntryShared
import OneEntryCore
import OneEntryForm

public struct FormDataContainer: Registrable, Updatable, Sendable {
    public typealias T = OneEntryForm.Locale
    
    public var data: [String : [Form.Data]] = [:]
    
    public init(@DSLBuilder<T> perform body: () -> [T]) {
        for item in body() {
            data[item.langCode, default: []] += item.data
        }
    }
}
