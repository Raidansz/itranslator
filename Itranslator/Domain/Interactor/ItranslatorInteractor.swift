//
//  ItranslatorInteractor.swift
//  Itranslator
//
//  Created by Raidan on 13/04/2024.
//

import Foundation
struct ItranslatorInteractor: ItranslatorInteractorProtocol {
    private var itranslatorRepository: ItranslatorRepositoryProtocol = ItranslatorRepository()
    init(itranslatorRepository: ItranslatorRepositoryProtocol = ItranslatorRepository()) {
        self.itranslatorRepository = itranslatorRepository
    }
    func invoke(sourceText: String, sourceLanguage: String, targetLanguages: String)  async throws -> [ItranslatorModel] {
       let itranslatorModel = try await itranslatorRepository.translateText(sourceText: sourceText, sourceLanguage: sourceLanguage, targetLanguage: targetLanguages)
        return itranslatorModel
    }
}

protocol ItranslatorInteractorProtocol {
    func invoke(sourceText: String, sourceLanguage: String, targetLanguages: String) async throws -> [ItranslatorModel]
}
