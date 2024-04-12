//
//  ItranslatorInteractor.swift
//  Itranslator
//
//  Created by Raidan on 13/04/2024.
//

import Foundation
struct ItranslatorInteractor : ItranslatorInteractorProtocol {
    private var itranslatorRepository:ItranslatorRepositoryProtocol = ItranslatorRepository()
    
    init(itranslatorRepository: ItranslatorRepositoryProtocol) {
        self.itranslatorRepository = itranslatorRepository
    }
    
    
    func invoke(sourceText: String, sourceLanguage: String, targetLanguages: String) async throws -> [ItranslatorModel] {
        try await itranslatorRepository.translateText(sourceText: sourceText, sourceLanguage: sourceLanguage, targetLanguages: targetLanguages)
    }
    
    
    
}




protocol ItranslatorInteractorProtocol {
    func invoke(sourceText: String, sourceLanguage: String, targetLanguages: String) async throws -> [ItranslatorModel]
}
