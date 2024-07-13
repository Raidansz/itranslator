//
//  TranslationHistoryView.swift
//  Itranslator
//
//  Created by Raidan on 28/04/2024.
//

import SwiftUI

struct TranslationHistoryView: View {
    @ObservedObject var viewModel = TranslationHistoryViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.sectionTitles, id: \.self) { sectionTitle in
                    Section(header: Text(sectionTitle)) {
                        ForEach(viewModel.groupedTranslations[sectionTitle] ?? [], id: \.id) { translation in
                            VStack(alignment: .leading,spacing: 8) {
                                Text(translation.sourceText)
                                Text(translation.outputText)
                            }
                            .padding(.vertical, 4) // Add vertical padding between cells
                        }
                        .onDelete { indexSet in
                            viewModel.deleteTranslation(at: indexSet, section: sectionTitle)
                        }
                    }
                }
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 0))

            .navigationTitle("Translations")
            .onAppear {
                viewModel.loadTranslations()
            }
        }
    }
    
    private var itemDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
}

#Preview {
    TranslationHistoryView()
}

