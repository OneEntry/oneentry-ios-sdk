//
//  AuthProviderService+DSL.swift
//  OneEntry
//
//  Created by Archibbald on 12/25/24.
//

import Foundation

@preconcurrency import OneEntryShared
import OneEntryCore

public extension AuthProviderService {
    @discardableResult
    func signUp(
        marker: String,
        formIdentifier: String,
        langCode: String = "en_US",
        isolation: isolated (any Actor)? = #isolation,
        @DSLBuilder<Registrable> perform body: () -> [any Registrable]
    ) async throws -> CreatedUser {
        let body = body()
        let formData = body.compactMap { ($0 as? FormDataContainer)?.data }
        let authData = body.compactMap { ($0 as? AuthDataContainer)?.data }
        let notificationData = body.compactMap { ($0 as? NotificationData)?.data }
        
        return try await signUp(marker: marker, formIdentifier: formIdentifier, langCode: langCode) { builder in
            for data in formData {
                builder.formData(data: data)
            }
            
            for data in authData {
                builder.authData(data: data)
            }
            
            for data in notificationData {
                builder.notificationData(notificationData: data)
            }
        }
    }
    
    @discardableResult
    func auth(
        marker: String,
        isolation: isolated (any Actor)? = #isolation,
        @DSLBuilder<AuthData> perform body: () -> [AuthData]
    ) async throws -> UserTokenDto {
        let authData = body()
        
        return try await auth(marker: marker) { builder in
            builder.putAll(data: authData)
        }
    }
}
