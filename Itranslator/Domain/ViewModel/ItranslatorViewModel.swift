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
    @Published private(set) var translationHistoryModel: [Translation] = []
    // MARK: - Input
    @Published var textToBeTranslated: String = ""
    @Published var currentTranslationModel: Translation?

    // MARK: - Initialization
    init(itranslatorInteractor: ItranslatorInteractorProtocol = ItranslatorInteractor()) {
        self.itranslatorInteractor = itranslatorInteractor
        translate(sourceText: "Hello friend", sourceLanguage: "en", targetLanguages: "ar")
    }
    deinit {
        print("deinit")
    }
    func translate(sourceText: String, sourceLanguage: String, targetLanguages: String) {
        Task {
            let response = try await itranslatorInteractor.invoke(sourceText: sourceText, sourceLanguage: sourceLanguage, targetLanguages: targetLanguages).first?.translations
            if let response = response {
              await MainActor.run {
                  translationHistoryModel.append(contentsOf: response)
                  currentTranslationModel = response.first
                //  print(response)
                }
            }
        }
    }

}
