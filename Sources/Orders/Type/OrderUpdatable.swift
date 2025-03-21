//
//  OrderUpdatable.swift
//  OneEntry
//
//  Created by Archibbald on 12/26/24.
//

import Foundation

public protocol OrderUpdatable {
    associatedtype Data
    
    var data: Data { get }
}
