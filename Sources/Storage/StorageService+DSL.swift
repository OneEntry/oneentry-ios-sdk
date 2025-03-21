//
//  StorageService+DSL.swift
//  OneEntry
//
//  Created by Archibbald on 12/31/24.
//

import Foundation

import OneEntryShared
import OneEntryCore

public extension StorageService {
    func upload(
        id: Int32,
        type: String,
        entity: String,
        width: Double? = nil,
        height: Double? = nil,
        compress: Bool = false,
        @DSLBuilder<OneEntryShared.File> files: () -> [OneEntryShared.File]
    ) async throws -> [UploadResult] {
        let files = files()
        
        return try await upload(
            id: id,
            type: type,
            entity: entity,
            width: width.map { .init(double: $0) },
            height: width.map { .init(double: $0) },
            compress: compress
        ) { builder in
            builder.addAll(files: files)
        }
    }
    
    func content(
        filename: String,
        id: Int,
        type: String,
        entity: String
    ) async throws -> Data {
        let bytes = try await _content(
            filename: filename,
            id: Int32(id),
            type: type,
            entity: entity
        )
        
        return bytes.toNSData()
    }
}
