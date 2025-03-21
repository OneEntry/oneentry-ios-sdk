//
//  CatalogService+SmartSearch.swift
//  OneEntry
//
//  Created by Archibbald on 12/17/24.
//

import Foundation

import OneEntryShared
import OneEntryCore

public extension CatalogService {
    func all(
        offset: Int = 0,
        limit: Int = 30,
        sortKey: String? = nil,
        sortOrder: OneEntryShared.SortOrder = .desc,
        langCode: String = "en_US",
        @DSLBuilder<ConditionBlock> filter: @Sendable () -> [ConditionBlock] = { [] }
    ) async throws -> Result<Product> {
        let builder = FilterProductsListBuilder()
        filter().forEach { condition in
            builder.put(builder: condition.builder)
        }
        
        return try await all(
            offset: .init(offset),
            limit: .init(limit),
            sortKey: sortKey,
            sortOrder: sortOrder,
            langCode: langCode
        ) {
            $0.doCopy(builder: builder)
        }
    }
    
    func byPage(
        id: Int,
        offset: Int = 0,
        limit: Int = 30,
        sortKey: String? = nil,
        sortOrder: OneEntryShared.SortOrder = .desc,
        langCode: String = "en_US",
        @DSLBuilder<ConditionBlock> filter: @Sendable () -> [ConditionBlock] = { [] }
    ) async throws -> Result<Product> {
        let builder = FilterProductsListBuilder()
        filter().forEach { condition in
            builder.put(builder: condition.builder)
        }
        
        return try await byPage(
            id: .init(id),
            offset: .init(offset),
            limit: .init(limit),
            sortKey: sortKey,
            sortOrder: sortOrder,
            langCode: langCode
        ) {
            $0.doCopy(builder: builder)
        }
    }
    
    func byPage(
        url: String,
        offset: Int = 0,
        limit: Int = 30,
        sortKey: String? = nil,
        sortOrder: OneEntryShared.SortOrder = .desc,
        langCode: String = "en_US",
        @DSLBuilder<ConditionBlock> filter: @Sendable () -> [ConditionBlock] = { [] }
    ) async throws -> Result<Product> {
        let builder = FilterProductsListBuilder()
        filter().forEach { condition in
            builder.put(builder: condition.builder)
        }
        
        return try await byPage(
            url: url,
            offset: .init(offset),
            limit: .init(limit),
            sortKey: sortKey,
            sortOrder: sortOrder,
            langCode: langCode
        ) {
            $0.doCopy(builder: builder)
        }
    }
}
