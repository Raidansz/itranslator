//
//  ItranslatorViewModel.swift
//  Itranslator
//
//  Created by Raidan on 12/04/2024.
//

import Foundation
import Combine
import Firebase
import FirebaseFirestore
import FirebaseAuth

class ItranslatorViewModel: ObservableObject {
    // MARK: - Properties
    private let itranslatorInteractor: ItranslatorInteractorProtocol
    let db = Firestore.firestore()
    // MARK: - Output
    @Published private(set) var translationHistoryModel: [Translation] = []
    // MARK: - Input
    @Published var textToBeTranslated: String?
    @Published var currentTranslationModel: Translation?
    // MARK: - Initialization
    init(itranslatorInteractor: ItranslatorInteractorProtocol = ItranslatorInteractor()) {
        self.itranslatorInteractor = itranslatorInteractor
    }
    deinit {
        print("deinit")
    }
    func translate(sourceText: String, sourceLanguage: String, targetLanguages: String, completion: @escaping () -> Void) {
           Task {
             //  do {
                   let response = try await itranslatorInteractor.invoke(sourceText: sourceText, sourceLanguage: sourceLanguage, targetLanguages: targetLanguages).first?.translations
                   if let response = response {
                       await MainActor.run {
                           self.currentTranslationModel = response.first
                       }
                                           appendRemoteDB(sourceText: sourceText, translated: response.first?.text, sourceLanguage: sourceLanguage, targetLanguage: targetLanguages)

                       }
                       completion()

           }
       }

    
    func appendRemoteDB(sourceText: String?, translated: String?,sourceLanguage: String?,targetLanguage: String?){
        if let user = Auth.auth().currentUser?.email, let sourceText = sourceText, let translatedText = translated, let sourceLanguage = sourceLanguage , let targetLanguage = targetLanguage{
            db.collection("translationHistory").addDocument(data: [
                "user": user,
                "sourceText": sourceText,
                "outputText": translatedText,
                "sourceLanguage": sourceLanguage,
                "targetLanguage": targetLanguage,
                "date": Date()
            ]) { (error) in
                if let error = error {
                    print("Something went wrong \(error.localizedDescription)")
                } else {
                    print("Saved seccessfully!")
                    
                }
            }
        }
    }
    
}
