//
//  ItranslatorView.swift
//  Itranslator
//
//  Created by Raidan on 12/04/2024.
//
import SwiftUI
struct ItranslatorView: View {
    @ObservedObject var viewModel: ItranslatorViewModel
    @State private var debounceText: String = ""
    @State private var isEditing: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color(.secondarySystemBackground))
                    .frame(width: 400, height: 200)
                    .onTapGesture { // Resign focus when tapping outside
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                
                TextView(text: $debounceText, isEditing: $isEditing)
                    .padding()
                    .frame(width: 400, height: 200)
                    .background(Color(.secondarySystemBackground)) // Make entire frame writable
            }
            .padding(.horizontal)
            Spacer()
            
            Button("Translate") {
                viewModel.updateRemoteDB(translate: "raidan", translated: "اثاثاث")

                viewModel.translate(sourceText: debounceText, sourceLanguage: "en", targetLanguages: "ar")
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            Spacer()
            
            Text(viewModel.currentTranslationModel?.text ?? "")
                .padding()
                .frame(width: 400, height: 200)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(.secondarySystemBackground))
                )
                .padding(.horizontal)
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
    }
}

struct TextView: UIViewRepresentable {
    @Binding var text: String
    @Binding var isEditing: Bool
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = true
        textView.isScrollEnabled = true
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        if isEditing {
            uiView.becomeFirstResponder()
        } else {
            uiView.resignFirstResponder()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, isEditing: $isEditing)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: String
        @Binding var isEditing: Bool
        
        init(text: Binding<String>, isEditing: Binding<Bool>) {
            _text = text
            _isEditing = isEditing
        }
        
        func textViewDidChange(_ textView: UITextView) {
            text = textView.text
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            isEditing = true
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            isEditing = false
        }
    }
}
