//
//  ItranslatorView.swift
//  Itranslator
//
//  Created by Raidan on 12/04/2024.
//
import SwiftUI

struct ItranslatorView: View {
    @StateObject var viewModel: ItranslatorViewModel
    
    @Environment(\.colorScheme) private var colorScheme
    @State private var inputText = ""
    @State private var outputText = ""
    @State private var inputLanguage = ""
    @State private var outputLanguage = ""
    @State private var isInProcess = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @FocusState private var isInputTextEditorFocused: Bool
    @FocusState private var isOutputTextEditorFocused: Bool
    @Injected(\.sessionManager) private var sessionManager: SessionManagerProtocol

    var body: some View {
            NavigationView {
                VStack {
                    VStack {
                        VStack {
                            TranslatedEditor(inputText: $inputText, outputText: $outputText, inputLanguage: $inputLanguage, outputLanguage: $outputLanguage, isInProcess: $isInProcess, isInputTextEditorFocused: $isInputTextEditorFocused, isOutputTextEditorFocused: $isOutputTextEditorFocused, submit: submit)
                        }.background(oppositeColorForScheme).clipShape(
                            .rect(
                                topLeadingRadius: 0,
                                bottomLeadingRadius: 40,
                                bottomTrailingRadius: 40,
                                topTrailingRadius: 0
                            )
                        )

                        TranslateButtons(inputText: $inputText, outputText: $outputText, inputLanguage: $inputLanguage, outputLanguage: $outputLanguage, isInProcess: $isInProcess, isInputTextEditorFocused: $isInputTextEditorFocused, isOutputTextEditorFocused: $isOutputTextEditorFocused, submit: submit).background(colorScheme == .dark ? Color.blue.opacity(0.4) : Color.blue.opacity(0.1))
                    }
                }
                .background(oppositeColorForScheme)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        ToolbarPrincipalView().onTapGesture(perform: {
                            isInputTextEditorFocused = false
                            isOutputTextEditorFocused = false
                        })
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                        
                        
                        NavigationLink(destination: TranslationHistoryView()) {
                            Image(systemName: "menucard.fill")
                                .foregroundColor(colorForScheme)
                        }
                        Button(action: {
                            sessionManager.signOut()
                        }) {
                            Image(systemName: "arrow.backward.square.fill")
                                .foregroundColor(.primary)
                        }
                    }
                    }
                }
            }.accentColor(.black)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Bazinga!"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    
    private func submit() {
        if inputText.isEmpty {
            return
        }
        if inputLanguage == outputLanguage {
                // Show an alert if input and output languages are the same
                showAlert = true
                alertMessage = "You cannot translate to the same language."
                return
            }

        isInProcess = true
        outputText = ""

        viewModel.translate(sourceText: inputText, sourceLanguage: inputLanguage, targetLanguages: outputLanguage) {
            // This will get called after the translation is complete.
            self.outputText = self.viewModel.currentTranslationModel?.text ?? ""
            self.isInProcess = false
        }
    }
    
    var colorForScheme: Color {
        colorScheme == .dark ? .white : .black
    }
    
    var oppositeColorForScheme: Color {
        colorScheme == .dark ? .black : .white
    }
}

#Preview("Light mode") {
    ItranslatorView(viewModel: ItranslatorViewModel())
}
#Preview("Dark mode") {
    ItranslatorView(viewModel: ItranslatorViewModel()).environment(\.colorScheme, .dark)
}
