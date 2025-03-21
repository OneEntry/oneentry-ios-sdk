//
//  User+State.swift
//  OneEntry
//
//  Created by Archibbald on 12/26/24.
//

import Foundation

import OneEntryShared

public extension User {
    func state<T: Decodable>(type: T.Type = T.self) throws -> T {
        let json = try __encodeState()
        
        return try JSONDecoder().decode(type, from: Data(json.utf8))
    }
}
