//
//  LogLevel.swift
//  OneEntry
//
//  Created by Archibbald on 31.07.2025.
//

import Foundation

import OneEntryShared

public typealias LoggingLogLevel = Ktor_client_loggingLogLevel

public struct LogLevel: AppConfig {
    var logLevel: LoggingLogLevel
    
    public init(_ level: LoggingLogLevel) {
        self.logLevel = level
    }
    
    public func apply(to config: OneEntryAppConfiguration) {
        config.logLevel = logLevel
    }
}
