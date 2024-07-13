//
//  TranslationHistoryViewModel.swift
//  Itranslator
//
//  Created by Raidan on 28/04/2024.
//

import Foundation

import Firebase


class TranslationHistoryViewModel: ObservableObject {
    @Published var groupedTranslations = [String: [TranslationHistory]]()  // Grouped by date as String
    @Published var sectionTitles = [String]()  // To maintain order

    private var db = Firestore.firestore()

    func loadTranslations() {
        db.collection("translationHistory")
            .order(by: "date", descending: true)
            .addSnapshotListener { [weak self] querySnapshot, error in
                if let error = error {
                    print("Error retrieving data: \(error.localizedDescription)")
                } else {
                    guard let documents = querySnapshot?.documents else {
                        print("No documents in 'translationHistory'")
                        return
                    }
                    self?.processDocuments(documents)
                }
            }
    }

    private func processDocuments(_ documents: [QueryDocumentSnapshot]) {
        var newGroupedTranslations = [String: [TranslationHistory]]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none

        for document in documents {
            let data = document.data()
            if let user = data["user"] as? String,
               let sourceText = data["sourceText"] as? String,
               let outputText = data["outputText"] as? String,
               let sourceLanguage = data["sourceLanguage"] as? String,
               let targetLanguage = data["targetLanguage"] as? String,
               let timestamp = data["date"] as? Timestamp {
                let date = timestamp.dateValue()
                let dateString = dateFormatter.string(from: date)

                let translation = TranslationHistory(id: document.documentID, user: user, sourceText: sourceText, outputText: outputText, sourceLanguage: sourceLanguage, targetLanguage: targetLanguage, date: date)

                newGroupedTranslations[dateString, default: []].append(translation)
            }
        }

        DispatchQueue.main.async {
            self.groupedTranslations = newGroupedTranslations
            self.sectionTitles = newGroupedTranslations.keys.sorted().reversed()
        }
    }
    
    func deleteTranslation(at indexSet: IndexSet, section: String) {
        guard let index = indexSet.first, let translation = groupedTranslations[section]?[index] else { return }
        // Remove from Firestore
        db.collection("translationHistory").document(translation.id).delete { error in
            if let error = error {
                print("Error removing document: \(error)")
            } else {
                DispatchQueue.main.async {
                    // Remove from local data
                    self.groupedTranslations[section]?.remove(at: index)
                    // Clean up section if empty
                    if self.groupedTranslations[section]?.isEmpty ?? false {
                        self.groupedTranslations.removeValue(forKey: section)
                        self.sectionTitles = self.sectionTitles.filter { $0 != section }
                    }
                }
            }}}
}
