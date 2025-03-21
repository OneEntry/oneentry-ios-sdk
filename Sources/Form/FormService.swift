//
//  FormService.swift
//  OneEntry
//
//  Created by Archibbald on 12/24/24.
//

import Foundation

@preconcurrency import OneEntryShared
import OneEntryCore

public extension FormsService {
    @discardableResult
    func sendData(
        formIdentifier: String,
        isolation: isolated (any Actor)? = #isolation,
        @DSLBuilder<Locale> perform body: () -> [Locale]
    ) async throws -> FormDataSubmitting {
        let locales = body()
        
        return try await sendData(formIdentifier: formIdentifier) { builder in
            for locale in locales {
                builder.locale(langCode: locale.langCode) { builder in
                    for data in locale.data {
                        builder.put(data: data)
                    }
                }
            }
        }
    }
}
