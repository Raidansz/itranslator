//
//  ItranslatorViewModel.swift
//  Itranslator
//
//  Created by Raidan on 12/04/2024.
//

import Foundation
import Combine

class TranslationViewModel: ObservableObject {
    //MARK: - Properties
    private let itranslatorInteractor: ItranslatorInteractorProtocol
    //MARK: - Output
    @Published private(set) var translatedText:String = ""
    
    
    
    
    //MARK: - Initialization
    init(ItranslatorInteractor: ItranslatorInteractorProtocol, translatedText: String) {
        self.itranslatorInteractor = ItranslatorInteractor
        self.translatedText = translatedText
        translate(sourceText: "en", sourceLanguage: "ar", targetLanguages: "ar")
    }
    deinit {
        print("deinit")
    }
    
    func translate(sourceText: String, sourceLanguage: String, targetLanguages: String) {
        Task {
            do {
                try await itranslatorInteractor.invoke(sourceText:sourceText , sourceLanguage: sourceLanguage, targetLanguages: targetLanguages)
                
            }catch{
                
            }
        }
    }
}
