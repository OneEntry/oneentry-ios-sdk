//
//  PaymentTests.swift
//  OneEntry
//
//  Created by Archibbald on 2/18/25.
//

import Testing

import OneEntryShared
import OneEntryAuth
import OneEntryCore

struct PaymentTests {
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
    func create() async throws {
        let result = try await OrdersService.shared.all(
            marker: "delivery",
            offset: 0,
            limit: 1,
            langCode: "en_US"
        )
        
        let order = try #require(result.items().first)
        
        try await PaymentsService.shared.purchase(
            orderId: order.id,
            type: .intent,
            automaticTaxEnabled: true
        )
        
        try await PaymentsService.shared.purchase(
            orderId: order.id,
            type: .session,
            automaticTaxEnabled: true
        )
    }
    
    @Test
    func sessions() async throws {
        let result = try await PaymentsService.shared.sessions(
            offset: 0,
            limit: 30
        )
        
        let payments = result.items()
        
        #expect(payments.contains { $0 is PaymentSession.Intent })
        #expect(payments.contains { $0 is PaymentSession.Session })
        #expect(result.total > 0)
    }
    
    @Test
    func accounts() async throws {
        let accounts = try await PaymentsService.shared.accounts()
        
        #expect(!accounts.isEmpty)
    }
}
