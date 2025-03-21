//
//  OrderStatus.swift
//  OneEntry
//
//  Created by Archibbald on 12/26/24.
//

import Foundation

public struct OrderStatus: OrderUpdatable {
    public var data: String?
    
    public init(_ status: String?) {
        self.data = status
    }
}
