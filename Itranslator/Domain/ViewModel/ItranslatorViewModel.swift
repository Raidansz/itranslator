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
       // translate(sourceText: "Hello friend", sourceLanguage: "en", targetLanguages: "ar")
        Auth.auth().signIn(withEmail: "raidanshugaa@gmail.com", password: "123456789sho") { [weak self] authResult, error in
            if let error = error {
                print(error)
            } else {
                print("ok")
            }}
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
                }
            }
        }
    }
    
     func updateRemoteDB(translate: String?, translated: String?){
        if let user = Auth.auth().currentUser?.email, let translateText = translate, let translatedText = translated{
            db.collection("translationHistory").addDocument(data: [
                "user": user,
                "translateText": translateText,
                "translatedText": translatedText,
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
