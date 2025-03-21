//
//  CertificateInitialization.swift
//  OneEntry
//
//  Created by Archibbald on 11/27/24.
//

import Foundation
import OneEntryShared

public extension OneEntryCore {
    func initialize(
        host: String,
        certificate name: String,
        password: String? = nil,
        bundle: Bundle = .main
    ) throws {
        let path = bundle.path(forResource: name, ofType: "p12")
        
        guard let path else { throw OneEntryCredentialError.certificateNotFound(name + ".p12") }
        
        try initialize(host: host, path: path, password: password)
    }
}

public extension OneEntryCore {
    enum OneEntryCredentialError: LocalizedError {
        case certificateNotFound(String)
        
        public var errorDescription: String? {
            switch self {
                case .certificateNotFound(let name): return "Certificate \"\(name)\" not found"
            }
        }
    }
}
