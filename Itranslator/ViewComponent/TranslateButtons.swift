//
//  TranslateButtons.swift
//  Itranslator
//
//  Created by Raidan on 28/04/2024.
//

import SwiftUI

struct TranslateButtons: View {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var inputText: String
    @Binding var outputText: String
    @Binding var inputLanguage: String
    @Binding var outputLanguage: String
    @Binding var isInProcess: Bool
    @FocusState.Binding var isInputTextEditorFocused: Bool
    @FocusState.Binding var isOutputTextEditorFocused: Bool
    var submit: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                LanguagePicker(languages: languages, selectedLanguage: $inputLanguage)
                    .padding(5)
                    .background(oppositeColorForScheme)
                    .cornerRadius(10)
                    .pickerStyle(MenuPickerStyle())
                    .foregroundColor(colorForScheme)
                    .accentColor(colorForScheme)
                    .frame(width: 150)
                
                Button(action: swapLanguages) {
                    Image(systemName: "arrow.left.arrow.right")
                        .font(.title2)
                        .foregroundColor(colorForScheme)
                }
                LanguagePicker(languages: languages, selectedLanguage: $outputLanguage)
                    .padding(5)
                    .background(oppositeColorForScheme)
                    .cornerRadius(10)
                    .pickerStyle(MenuPickerStyle())
                    .foregroundColor(colorForScheme)
                    .accentColor(colorForScheme)
                    .frame(width: 150)
                
                Spacer()
            }.frame(height:  30 ).padding(.top,  20 ).padding(.bottom, (!isInputTextEditorFocused && !isOutputTextEditorFocused) ? 0 : 20)
            
            if (!isInputTextEditorFocused && !isOutputTextEditorFocused) {
                HStack {
//                    LanguagePicker(languages: languages, selectedLanguage: $outputLanguage)
//                        .padding(5)
//                        .background(oppositeColorForScheme)
//                        .cornerRadius(10)
//                        .pickerStyle(MenuPickerStyle())
//                        .foregroundColor(colorForScheme)
//                        .accentColor(colorForScheme)
//                        .frame(width: 350)
                    
                    Spacer().frame(width: 350)
                    Button (action: {
                        
                        submit()
                        
                    }) {
                        ZStack {
                            if (isInProcess) {
                                Spinner().frame(width: 60, height: 60)
                            }
                            Image(systemName: "arrow.forward.circle.fill")
                                .font(.system(size: 50))
                                .foregroundColor(colorForScheme)
                        }
                    }
                    Spacer()
                }.padding(.top, 15)
            }
        }
    }
    
    func swapLanguages() {
        guard inputLanguage != outputLanguage else { return }
        let temp = inputLanguage
        inputLanguage = outputLanguage
        outputLanguage = temp
        
        let tempText = inputText
        inputText = outputText
        outputText = tempText
    }
    
    var colorForScheme: Color {
        colorScheme == .dark ? .white :  .black
    }
    
    var oppositeColorForScheme: Color {
        colorScheme == .dark ? .black : .white
    }
}



