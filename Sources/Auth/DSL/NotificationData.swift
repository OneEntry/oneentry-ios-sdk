//
//  NotificationData.swift
//  OneEntry
//
//  Created by Archibbald on 12/25/24.
//

import Foundation

import OneEntryShared

public struct NotificationData: Registrable, Updatable {
    public var data: UserNotificationData
    
    public init(
        email: String,
        phonePush: [String],
        phoneSMS: String
    ) {
        self.data = .init(
            email: email,
            phonePush: phonePush,
            phoneSMS: phoneSMS
        )
    }
}
