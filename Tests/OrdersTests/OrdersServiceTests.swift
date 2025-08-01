//
//  OrdersServiceTests.swift
//  OneEntry
//
//  Created by Archibbald on 12/26/24.
//

import Testing

@preconcurrency import OneEntryShared

import OneEntryCore
import OneEntryAuth
import OneEntryCatalog
import OneEntryOrders
import OneEntryForm
import OneEntryAttribute

struct OrdersServiceTests {
    init() async throws {
        OneEntryApp.shared.initialize(
            host: "hummel-mobile.oneentry.cloud",
            token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiS290bGluIE11bHRpcGxhdGZvcm0iLCJzZXJpYWxOdW1iZXIiOjMsImlhdCI6MTczNTMyMjQ2NywiZXhwIjoxNzY2ODU4NDQ4fQ.3YZHZ39povhcmUpUAgMiD5b4NuZ9zK5ThObVYqkmvuk"
        ) {
            LogLevel(.all)
        }
        
        try await AuthProviderService.shared.auth(marker: "email") {
            AuthData(marker: "email_auth", value: "artikdanilov@gmail.com")
            AuthData(marker: "pass_auth", value: "password")
        }
    }
    
    @Test
    func creating() async throws {
        let settingAddress = "New York"
        let settingComment = "Test comment"
        let catalog = try await CatalogService.shared.all(limit: 3).items()
        let order = try await OrdersService.shared.create(
            marker: "delivery",
            formIdentifier: "delivery",
            paymentAccountIdentifier: "stripe"
        ) {
            FormDataContainer {
                Locale("en_US") {
                    FormData(marker: "address", attribute: .init(string: settingAddress))
                    FormData(marker: "comment", attribute: .init(string: settingComment))
                }
            }
            
            ProductsContainer {
                for product in catalog {
                    OrderProduct(id: product.id, quantity: .random(in: 1...10))
                }
            }
        }
        
        let addressData = order.formData["en_US"]?.first { $0.marker == "address" }
        let commentData = order.formData["en_US"]?.first { $0.marker == "comment" }
        
        let address = try #require(try? addressData?.valueAsString())
        let comment = try #require(try? commentData?.valueAsString())
        
        order.products.forEach { product in
            #expect(catalog.contains { $0.id == product.id })
        }
        
        #expect(settingAddress == address)
        #expect(settingComment == comment)
    }
    
    @Test
    func update() async throws {
        let orders = try await OrdersService.shared.all(marker: "delivery", offset: 0, limit: 30, langCode: "en_US")
        let id = try #require(orders.items().randomElement()?.id)
        let status = "delivered"
        
        let order = try await OrdersService.shared.update(
            id: id,
            marker: "delivery",
            formIdentifier: "delivery",
            paymentAccountIdentifier: "stripe"
        ) {
            OrderStatus(status)
        }
        
        #expect(order.statusIdentifier == status)
    }
}
