//
//  UserTests.swift
//  OneEntry
//
//  Created by Archibbald on 12/25/24.
//

import Testing

import OneEntryShared
import OneEntryAuth
import OneEntryForm
import OneEntryCore

struct Test {
    let authProviderMarker = "email"
    let userIdentifier = "artikdanilov@gmail.com"
    
    init() async throws {
        OneEntryApp.shared.initialize(
            host: "hummel-mobile.oneentry.cloud",
            token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiS290bGluIE11bHRpcGxhdGZvcm0iLCJzZXJpYWxOdW1iZXIiOjMsImlhdCI6MTczNTMyMjQ2NywiZXhwIjoxNzY2ODU4NDQ4fQ.3YZHZ39povhcmUpUAgMiD5b4NuZ9zK5ThObVYqkmvuk"
        ) {
            LogLevel(.all)
        }
        
        try await AuthProviderService.shared.auth(marker: authProviderMarker) {
            AuthData(marker: "email_auth", value: userIdentifier)
            AuthData(marker: "pass_auth", value: "password")
        }
    }
    
    @Test
    func update() async throws {
        let oldUser = try await UserService.shared.me(langCode: "en_US")
        let oldNameData = oldUser.formData["en_US"]?.first { $0.marker == "name_auth" }
        let oldName = try #require(try? oldNameData?.valueAsString())
        
        let settingName = oldName == "Archibbald" ? "Arthur" : "Archibbald"
        let settingFavorite = Int32.random(in: 0..<Int32.max)
        let settingState = ["favorite_product" : settingFavorite]
        
        try await UserService.shared.update(formIdentifier: "email_auth") {
            FormDataContainer {
                Locale("en_US") {
                    FormData(marker: "name_auth", attribute: .init(string: settingName))
                }
            }
            
            State(settingState)
        }
        
        let user = try await UserService.shared.me(langCode: "en_US")
        let name = try user.formData["en_US"]?.first { $0.marker == "name_auth" }?.valueAsString()
        let state: [String : Int32] = try user.state()
        let favorite = state["favorite_product"]
        
        #expect(settingName == name)
        #expect(settingFavorite == favorite)
    }
}
