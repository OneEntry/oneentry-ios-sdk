//
//  OneEntryApp+initialize.swift
//  OneEntry
//
//  Created by Archibbald on 11/27/24.
//

import Foundation
import OneEntryShared

public extension OneEntryApp {
    func initialize(
        host: String,
        certificate name: String,
        password: String? = nil,
        bundle: Bundle = .main,
        @DSLBuilder<any AppConfig> configs: () -> [any AppConfig] = { [] }
    ) throws {
        let path = bundle.path(forResource: name, ofType: "p12")
        let configs = configs()
        
        guard let path else { throw OneEntryCredentialError.certificateNotFound(name + ".p12") }
        
        __initialize(host: host, path: path, password: password) { config in
            configs.forEach {
                $0.apply(to: config)
            }
        }
    }
        
    func initialize(
        host: String,
        token: String,
        @DSLBuilder<any AppConfig> configs: () -> [any AppConfig] = { [] },
    ) {
        let configs = configs()
        
        __initialize(host: host, token: token) { config in
            configs.forEach {
                $0.apply(to: config)
            }
        }
    }
}

public extension OneEntryApp {
    enum OneEntryCredentialError: LocalizedError {
        case certificateNotFound(String)
        
        public var errorDescription: String? {
            switch self {
                case .certificateNotFound(let name):
                    String(localized: "Certificate \"\(name)\" not found")
            }
        }
    }
}
