//
//  UserService+DSL.swift
//  OneEntry
//
//  Created by Archibbald on 12/24/24.
//

import Foundation

@preconcurrency import OneEntryShared
import OneEntryCore

public extension UserService {
    func update(
        formIdentifier: String,
        langCode: String = "en_US",
        isolation: isolated (any Actor)? = #isolation,
        @DSLBuilder<Updatable> perform body: () -> [any Updatable]
    ) async throws {
        let updatable = body()
        let formData = updatable.compactMap { ($0 as? FormDataContainer)?.data }
        let authData = updatable.compactMap { ($0 as? AuthDataContainer)?.data }
        let notificationData = updatable.compactMap { ($0 as? NotificationData)?.data }
        let stateData = updatable.compactMap { ($0 as? State)?.data }
        
        try await update(formIdentifier: formIdentifier, langCode: langCode) { builder in
            for data in formData {
                builder.formData(data: data)
            }
            
            for data in authData {
                builder.authData(data: data)
            }
            
            for data in notificationData {
                builder.notificationData(notificationData: data)
            }
            
            for data in stateData {
                let data = try? JSONEncoder().encode(data)
                let json = data.flatMap { String(data: $0, encoding: .utf8) }
                                
                guard let json else { continue }
                
                builder.state(json: json)
            }
        }
    }
}
