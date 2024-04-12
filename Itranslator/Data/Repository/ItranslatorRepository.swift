//
//  ItranslatorRepository.swift
//  Itranslator
//
//  Created by Raidan on 12/04/2024.
//

import Foundation


final class ItranslatorRepository: ItranslatorRepositoryProtocol {

    
    @Injected(\.azureManager) private var azureManager : AzureManagerProtocol
    
    private var itranslatorMapper: ItranslatorMapper {
        ItranslatorMapper()
    }
    
    func translateText(sourceText: String, sourceLanguage: String, targetLanguages: String) async throws -> [ItranslatorModel] {
        azureManager.translate(text: sourceText, from: sourceLanguage, to: [targetLanguages])

    }

    
    
}







protocol ItranslatorRepositoryProtocol {
   func translateText(sourceText: String, sourceLanguage: String, targetLanguages: String) async throws -> [ItranslatorModel]
}
