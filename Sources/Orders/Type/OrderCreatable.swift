//
//  OrderCreatable.swift
//  OneEntry
//
//  Created by Archibbald on 12/26/24.
//

import Foundation

public protocol OrderCreatable: Sendable {
    associatedtype Data
    
    var data: Data { get }
}
