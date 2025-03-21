//
//  FormData.swift
//  OneEntry
//
//  Created by Archibbald on 12/24/24.
//

import Foundation

@preconcurrency import OneEntryShared

public struct FormData: Sendable {
    var data: Form.Data
    
    public init(data: Form.Data) {
        self.data = data
    }
    
    public init(marker: String, attribute: AttributeValue) {
        self.data = Form.Data(marker: marker, attribute: attribute)
    }
}
