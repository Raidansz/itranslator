//
//  AzureManagerProtocol.swift
//  Itranslator
//
//  Created by Raidan on 13/04/2024.
//

import Foundation
protocol ItranslatorManagerProtocol {
    func translate(text: String, from sourceLanguage: String, to targetLanguage: String, completion: @escaping (Result<String, Error>) -> Void)

}
