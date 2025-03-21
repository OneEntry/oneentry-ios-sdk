//
//  Updatable.swift
//  OneEntry
//
//  Created by Archibbald on 12/25/24.
//

import Foundation

public protocol Updatable {
    associatedtype Data
    
    var data: Data { get }
}
