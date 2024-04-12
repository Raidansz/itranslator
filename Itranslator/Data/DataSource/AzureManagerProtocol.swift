//
//  AzureManagerProtocol.swift
//  Itranslator
//
//  Created by Raidan on 13/04/2024.
//

import Foundation
protocol AzureManagerProtocol {
    func translate(text: String, from sourceLanguage: String, to targetLanguages: [String]) -> [ItranslatorModel]

}
