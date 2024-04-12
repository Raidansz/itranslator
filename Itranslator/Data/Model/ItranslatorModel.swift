//
//  ItranslatorModel.swift
//  Itranslator
//
//  Created by Raidan on 12/04/2024.
//

import Foundation
struct ItranslatorModel: Codable {
    let code: String
    let name: String
    let nativeName: String
    let dir: String // Direction
}
