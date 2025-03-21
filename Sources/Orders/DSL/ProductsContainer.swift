//
//  ProductsContainer.swift
//  OneEntry
//
//  Created by Archibbald on 12/26/24.
//

import Foundation

@preconcurrency import OneEntryShared
import OneEntryCore

public struct ProductsContainer: OrderCreatable, OrderUpdatable {
    public typealias Data = [OneEntryShared.OrderProduct]
    
    public var data: Data
    
    public init(@DSLBuilder<OneEntryShared.OrderProduct> builder: @Sendable () -> Data) {
        self.data = builder()
    }
}
