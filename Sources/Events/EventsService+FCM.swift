//
//  EventsService+FCM.swift
//  OneEntry
//
//  Created by Archibbald on 3/4/25.
//

import Foundation
import os.log

import OneEntryShared

public extension EventsService {
    func registerForPushNotifications(fcm token: String) {
        Task.detached {
            do {
                try await UserService.shared.updateFCM(token: token)
            } catch {
                let message = "Failed to subscribe to the newsletter with an error: \(error)"
                
                if #available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *) {
                    let logger = Logger(subsystem: "OneEntry", category: "Events")
                    logger.error("\(message)")
                } else {
                    print(message)
                }
            }
        }
    }
}
