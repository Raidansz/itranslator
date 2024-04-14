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
