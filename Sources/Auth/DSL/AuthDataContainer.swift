//
//  AuthDataContainer.swift
//  OneEntry
//
//  Created by Archibbald on 12/25/24.
//

import Foundation

import OneEntryShared
import OneEntryCore

public struct AuthDataContainer: Registrable, Updatable {
    public var data: [AuthData] = []
    
    public init(@DSLBuilder<AuthData> perform body: () -> [AuthData]) {
        self.data = body()
    }
}
