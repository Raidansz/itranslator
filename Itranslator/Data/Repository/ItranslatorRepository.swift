//
//  ItranslatorRepository.swift
//  Itranslator
//
//  Created by Raidan on 12/04/2024.
//

import Foundation

final class ItranslatorRepository: ItranslatorRepositoryProtocol {

    @Injected(\.itranslatorManager) private var itranslatorManager: ItranslatorManagerProtocol
    private var itranslatorMapper: ItranslatorMapper {
        ItranslatorMapper()
    }
    init(itranslatorManager: ItranslatorManagerProtocol = ItranslatorManager()) {
        self.itranslatorManager = itranslatorManager
    }
    func translateText(sourceText: String, sourceLanguage: String, targetLanguage: String) async throws -> [ItranslatorModel] {
        return try await withCheckedThrowingContinuation { continuation in
            itranslatorManager.translate(text: sourceText, from: sourceLanguage, to: targetLanguage) { result in
                switch result {
                case .success(let translated):
                    do {
                        let models = try self.itranslatorMapper.map(networkResponse: translated)
                        continuation.resume(returning: models)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

}

protocol ItranslatorRepositoryProtocol {
   func translateText(sourceText: String, sourceLanguage: String, targetLanguage: String) async throws -> [ItranslatorModel]
}
