//
//  Attributable+Date.swift
//  OneEntry
//
//  Created by Archibbald on 3/4/25.
//

import Foundation

import OneEntryShared

public extension Attributable {
    func valueAsFoundationDate() throws -> Foundation.Date {
        let date = try valueAsDate()
        let formatter = DateFormatter()
        formatter.dateFormat = date.format
        
        let foundationDate = formatter.date(from: date.formattedValue)
        
        guard let foundationDate else { throw NSError(domain: "DateFormattingError", code: 500) }
                    
        return foundationDate
    }
}
