//
//  LaunchView.swift
//  Itranslator
//
//  Created by Raidan on 18/04/2024.
//

import SwiftUI

struct LaunchView: View {
    @StateObject var viewModel: LaunchViewModel
    @Environment(\.colorScheme) var colorScheme
    
    let languages = [
        "English": "Hello",
        "Spanish": "Hola",
        "French": "Bonjour",
        "German": "Hallo",
        "Italian": "Ciao",
        "Japanese": "こんにちは",
        "Russian": "Привет",
        "Chinese": "你好",
        "Arabic": "مرحبا",
        "Portuguese": "Olá",
        "Korean": "안녕하세요",
        "Dutch": "Hallo",
        "Swedish": "Hej",
        "Greek": "Γεια σας",
        "Turkish": "Merhaba",
        "Hindi": "नमस्ते",
        "Bengali": "হ্যালো",
        "Vietnamese": "Xin chào",
        "Thai": "สวัสดี",
        "Hebrew": "שלום",
        "Polish": "Cześć",
        "Indonesian": "Halo",
        "Czech": "Ahoj",
        "Hungarian": "Szia",
        "Finnish": "Hei",
        "Danish": "Hej",
        "Norwegian": "Hei",
        "Romanian": "Salut"
    ]
    
    var body: some View {
        ZStack {
            colorScheme == .dark ? Color.black : Color.white
            VStack(spacing: 20) {
                ForEach(Array(languages.keys.enumerated()), id: \.offset) { index, language in
                    Text(languages[language]!)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    //  .blur(radius: 0.5)
                        .offset(
                            x: CGFloat.random(in: -400...400),
                            y: CGFloat.random(in: -50...50)
                        )
                        .opacity(viewModel.opacities[index])
                        .animation(
                            Animation
                                .easeInOut(duration: 6)
                                .repeatForever(autoreverses: true),
                            value: UUID()
                        )                        .onAppear {
                            viewModel.objectWillChange.send()
                        }
                }
            }
        }
        .padding()
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    LaunchView(viewModel: LaunchViewModel(languagesCount: 30))
}
