//
//  CustomKeystore.swift
//  OneEntry
//
//  Created by Archibbald on 31.07.2025.
//

import Foundation

import OneEntryShared

public typealias Keystore = Multiplatform_foundation_keystoreKeystore

public struct CustomKeystore: AppConfig {
    var keystore: Keystore
    
    public init(_ keystore: Keystore) {
        self.keystore = keystore
    }
    
    public func apply(to config: OneEntryAppConfiguration) {
        config.keystore = keystore
    }
}
