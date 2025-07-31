//
//  AppConfiguration.swift
//  OneEntry
//
//  Created by Archibbald on 31.07.2025.
//

import Foundation

import OneEntryShared

public protocol AppConfig {
    func apply(to config: OneEntryAppConfiguration)
}
