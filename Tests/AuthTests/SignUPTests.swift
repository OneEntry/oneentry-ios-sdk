//
//  Test.swift
//  OneEntry
//
//  Created by Archibbald on 12/25/24.
//

import Testing

import OneEntryAttribute
import OneEntryShared
import OneEntryCore
import OneEntryAuth
import OneEntryForm

struct SignUPTests {
    let authProviderMarker = "email"
    let userIdentifier = "artikdanilov@gmail.com"
    
    init() async throws {
        OneEntryApp.shared.initialize(
            host: "hummel-mobile.oneentry.cloud",
            token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiS290bGluIE11bHRpcGxhdGZvcm0iLCJzZXJpYWxOdW1iZXIiOjMsImlhdCI6MTczNTMyMjQ2NywiZXhwIjoxNzY2ODU4NDQ4fQ.3YZHZ39povhcmUpUAgMiD5b4NuZ9zK5ThObVYqkmvuk"
        ) {
            LogLevel(.all)
        }
    }
    
    @Test
    func signUp() async throws {
        try await AuthProviderService.shared.signUp(marker: authProviderMarker, formIdentifier: "email_auth") {
            FormDataContainer {
                Locale("en_US") {
                    FormData(marker: "name_auth", attribute: .init(string: "Arthur"))
                }
            }
            
            AuthDataContainer {
                AuthData(marker: "email_auth", value: userIdentifier)
                AuthData(marker: "pass_auth", value: "password")
            }
            
            NotificationData(
                email: userIdentifier,
                phonePush: ["some token"],
                phoneSMS: "+09999999999"
            )
        }
    }
    
    @Test
    func activate() async throws {
        try await AuthProviderService.shared.activate(
            marker: authProviderMarker,
            userIdentifier: userIdentifier,
            code: "684156"
        )
    }
}
