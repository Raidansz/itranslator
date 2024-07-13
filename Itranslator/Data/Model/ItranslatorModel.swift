//
//  ItranslatorModel.swift
//  Itranslator
//
//  Created by Raidan on 12/04/2024.
//

import Foundation
struct ItranslatorModel: Codable {
    let translations: [Translation]
}

struct Translation: Codable {
    let to: String
    let text: String
}

struct TranslationHistory: Identifiable {
        var id: String
        var user: String
        var sourceText: String
        var outputText: String
        var sourceLanguage: String
        var targetLanguage: String
        var date: Date
    }
