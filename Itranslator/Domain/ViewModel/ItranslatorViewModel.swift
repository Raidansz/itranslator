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
    @Published var opacities: [Double] = []

    private let itranslatorInteractor: ItranslatorInteractorProtocol
    // MARK: - Output
    @Published private(set) var translationModel: [Translation] = []
    // MARK: - Input
    @Published var textToBeTranslated: String = ""
    // MARK: - Initialization
    init(itranslatorInteractor: ItranslatorInteractorProtocol = ItranslatorInteractor() , languagesCount: Int) {
        self.itranslatorInteractor = itranslatorInteractor
        translate(sourceText: "Hello friend", sourceLanguage: "en", targetLanguages: "ar")
        startOpacityAnimation(languagesCount: languagesCount)
    }
    deinit {
        print("deinit")
    }
    func translate(sourceText: String, sourceLanguage: String, targetLanguages: String) {
        Task {
            let response = try await itranslatorInteractor.invoke(sourceText: sourceText, sourceLanguage: sourceLanguage, targetLanguages: targetLanguages).first?.translations
            if let response = response {
              await MainActor.run {
                  translationModel.append(contentsOf: response)
                  print(response)
                }
            }
        }
    }
    func startOpacityAnimation(languagesCount: Int) {
        // Initialize opacities with alternating values to simulate fading in and out
        for index in 0..<languagesCount {
            opacities.append(Double(index % 2))
        }
        
        // Update opacities every 2 seconds to simulate fading in and out smoothly
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
            for index in 0..<self.opacities.count {
                self.opacities[index] = self.opacities[index] == 1 ? 0 : 1
            }
            self.objectWillChange.send()
        }
    }

}
