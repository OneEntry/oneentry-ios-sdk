//
//  SocketTests.swift
//  OneEntry
//
//  Created by Archibbald on 2/25/25.
//

import Testing

import OneEntryShared
import OneEntryEvents
import OneEntryCatalog
import OneEntryAuth

final class SocketTests {
    let product: Product
    
    init() async throws {
        let authProviderMarker = "email"
        let userIdentifier = "artikdanilov@gmail.com"
        
        OneEntryCore.shared.initialize(
            host: "hummel-mobile.oneentry.cloud",
            token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiS290bGluIE11bHRpcGxhdGZvcm0iLCJzZXJpYWxOdW1iZXIiOjMsImlhdCI6MTczNTMyMjQ2NywiZXhwIjoxNzY2ODU4NDQ4fQ.3YZHZ39povhcmUpUAgMiD5b4NuZ9zK5ThObVYqkmvuk"
        )
        
        try await AuthProviderService.shared.auth(marker: authProviderMarker) {
            AuthData(marker: "email_auth", value: userIdentifier)
            AuthData(marker: "pass_auth", value: "password")
        }
        
        self.product = try await #require(CatalogService.shared.all().items().first)
        
        try await EventsService.shared.subscribeToProduct(
            id: product.id,
            marker: "product-status",
            langCode: "en_US"
        )
        
        print("Product: \(product.localizeInfos["en_US"]?.title ?? "")")
    }
    
    @Test
    func streaming() async throws {
        for try await event in EventsService.shared.notifications {
            #expect(product.id == event.product.id)
            
            return
        }
    }
    
    deinit {
        let id = product.id
        
        Task {
            try await EventsService.shared.unsubscribeFromProduct(
                id: id,
                marker: "product-status",
                langCode: "en_US"
            )
        }
    }
}
