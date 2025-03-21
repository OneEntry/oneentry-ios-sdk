//
//  OrdersService+DSL.swift
//  OneEntry
//
//  Created by Archibbald on 12/26/24.
//

import Foundation

import OneEntryShared
import OneEntryForm
import OneEntryAuth
import OneEntryCore

extension FormDataContainer: OrderCreatable, OrderUpdatable { }

public extension OrdersService {
    func create(
        marker: String,
        formIdentifier: String,
        paymentAccountIdentifier: String,
        langCode: String = "en_US",
        @DSLBuilder<OrderCreatable> perform body: @Sendable () -> [any OrderCreatable]
    ) async throws -> CreatedOrder {
        let body = body()
        let formData = body.compactMap { ($0 as? FormDataContainer)?.data }
        let productsData = body.compactMap { ($0 as? ProductsContainer)?.data }
        
        return try await create(
            marker: marker,
            formIdentifier: formIdentifier,
            paymentAccountIdentifier: paymentAccountIdentifier,
            langCode: langCode
        ) { builder in
            for data in formData {
                builder.formData(data: data)
            }
            
            for data in productsData {
                builder.products(data: data)
            }
        }
    }
    
    func update(
        id: Int32,
        marker: String,
        formIdentifier: String,
        paymentAccountIdentifier: String,
        langCode: String = "en_US",
        @DSLBuilder<OrderUpdatable> perform body: () -> [any OrderUpdatable]
    ) async throws -> CreatedOrder {
        let body = body()
        let formData = body.compactMap { ($0 as? FormDataContainer)?.data }
        let productsData = body.compactMap { ($0 as? ProductsContainer)?.data }
        let statusData = body.compactMap { ($0 as? OrderStatus)?.data }
        
        return try await update(
            id: id,
            marker: marker,
            formIdentifier: formIdentifier,
            paymentAccountIdentifier: paymentAccountIdentifier,
            langCode: langCode
        ) { builder in
            for data in formData {
                builder.formData(data: data)
            }
            
            for data in productsData {
                builder.products(data: data)
            }
            
            for data in statusData {
                builder.statusIdentifier = data
            }
        }
    }
}
