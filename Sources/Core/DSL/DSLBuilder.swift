//
//  DSLBuilder.swift
//  OneEntry
//
//  Created by Archibbald on 12/18/24.
//

import Foundation

@resultBuilder public final class DSLBuilder<Result> {
    public static func buildBlock(_ components: [Result]...) -> [Result] {
        return components.flatMap { $0 }
    }
            
    public static func buildEither(first component: [Result]) -> [Result] {
        return component
    }
    
    public static func buildEither(second component: [Result]) -> [Result] {
        return component
    }
    
    public static func buildOptional(_ component: [Result]?) -> [Result] {
        return component ?? []
    }
    
    public static func buildArray(_ components: [[Result]]) -> [Result] {
        return components.flatMap { $0 }
    }
    
    public static func buildExpression(_ expression: Result) -> [Result] {
        return [expression]
    }
    
    public static func buildExpression(_ expression: Void) -> [Result] {
        return []
    }
}
