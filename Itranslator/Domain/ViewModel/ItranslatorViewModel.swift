//
//  ItranslatorViewModel.swift
//  Itranslator
//
//  Created by Raidan on 12/04/2024.
//

import Foundation
import Combine

class ItranslatorViewModel: ObservableObject {
    // MARK: - Properties
    private let itranslatorInteractor: ItranslatorInteractorProtocol
    // MARK: - Output
    @Published private(set) var translationModel: [Translation] = []
    // MARK: - Input
    @Published var textToBeTranslated: String = ""
    // MARK: - Initialization
    init(itranslatorInteractor: ItranslatorInteractorProtocol = ItranslatorInteractor() ) {
        self.itranslatorInteractor = itranslatorInteractor
        translate(sourceText: "Hello friend", sourceLanguage: "en", targetLanguages: "ar")
    }
    deinit {
        print("deinit")
    }
    func translate(sourceText: String, sourceLanguage: String, targetLanguages: String) {
        Task {
            let response = try await itranslatorInteractor.invoke(sourceText: sourceText, sourceLanguage: sourceLanguage, targetLanguages: targetLanguages)
//            if let response = response {
//              await MainActor.run {
//                  translationModel.append(contentsOf: response.first?.translations ?? [])
//                }
//            }
        }
    }
}
