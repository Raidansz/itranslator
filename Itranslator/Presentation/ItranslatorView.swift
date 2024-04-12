//
//  ItranslatorView.swift
//  Itranslator
//
//  Created by Raidan on 12/04/2024.
//

import SwiftUI


    struct ItranslatorView: View {
        @ObservedObject var viewModel = TranslationViewModel()

        var body: some View {
            NavigationView {
                VStack {
                    TextField("Enter text here", text: $viewModel.sourceText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Text(viewModel.translatedText)
                            .padding()
                    }

                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }

                    Button("Translate to Arabic and Zulu") {
                        viewModel.translate(from: "en", to: ["ar", "zu"])
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
                }
                .navigationTitle("Translator")
            }
        }
    }



#Preview {
    ItranslatorView()
}
