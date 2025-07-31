//
//  AttributeValue+Date.swift
//  OneEntry
//
//  Created by Archibbald on 2/26/25.
//

import Foundation

import OneEntryShared

public extension AttributeValue {
    convenience init(
        dateTime: Foundation.Date,
        calendar: Calendar = .current,
        format: String = "dd-MM-yyyy HH:mm"
    ) {
        let timeZone = calendar.timeZone
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: dateTime)
        let attribute = AttributeValue.companion.fromDateTime(
            dateTime: .init(
                year: Int32(components.year ?? 0),
                month: Int32(components.month ?? 0),
                day: Int32(components.day ?? 0),
                hour: Int32(components.hour ?? 0),
                minute: Int32(components.minute ?? 0),
                second: Int32(components.second ?? 0),
                nanosecond: Int32(components.nanosecond ?? 0)
            ),
            timeZone: .companion.of(zoneId: timeZone.identifier),
            format: format
        )
        
        self.init(
            type: attribute.type,
            value: attribute.value
        )
    }
    
    convenience init(
        date: Foundation.Date,
        calendar: Calendar = .current,
        format: String = "dd-MM-yyyy"
    ) {
        let timeZone = calendar.timeZone
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let attribute = AttributeValue.companion.fromDate(
            date: .init(
                year: Int32(components.year ?? 0),
                month: Int32(components.month ?? 0),
                day: Int32(components.day ?? 0)
            ),
            timeZone: .companion.of(zoneId: timeZone.identifier),
            format: format
        )
        
        self.init(
            type: attribute.type,
            value: attribute.value
        )
    }
    
    convenience init(
        time: Foundation.Date,
        calendar: Calendar = .current,
        format: String = "HH:mm"
    ) {
        let timeZone = calendar.timeZone
        let components = calendar.dateComponents([.hour, .minute, .second, .nanosecond], from: time)
        let attribute = AttributeValue.companion.fromTime(
            time: Kotlinx_datetimeLocalTime(
                hour: Int32(components.hour ?? 0),
                minute: Int32(components.minute ?? 0),
                second: Int32(components.second ?? 0),
                nanosecond: Int32(components.nanosecond ?? 0)
            ),
            timeZone: .companion.of(zoneId: timeZone.identifier),
            format: format
        )
        
        self.init(
            type: attribute.type,
            value: attribute.value
        )
    }
}
