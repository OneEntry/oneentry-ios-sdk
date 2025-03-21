//
//  State.swift
//  OneEntry
//
//  Created by Archibbald on 12/25/24.
//

import Foundation

public struct State: Updatable {
    public var data: any Encodable
    
    public init<T: Encodable>(_ state: T) {
        self.data = state
    }
}
