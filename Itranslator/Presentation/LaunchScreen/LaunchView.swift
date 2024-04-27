//
//  LaunchView.swift
//  Itranslator
//
//  Created by Raidan on 18/04/2024.
//
import SwiftUI




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
            GlassBackGround()
            VStack(spacing: 20) {
                colorScheme == .dark ? Color.black : Color.white
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


struct GlassBackGround: View {
    @Environment(\.colorScheme) var colorScheme

    @State var width: CGFloat = 250
    @State var height: CGFloat = 250  // Adjusted for better initial fit
    @State var signin: Bool = true
    @State var signup: Bool = true
    @State var signinField: Bool = false
    @State var signupField: Bool = false
    @State var backwards: Bool = false
    @State private var email: String = ""
    @State private var navigateToITranslator: Bool = false
    @State private var password: String = ""
    @State private var confirmPassword: String = ""

    var body: some View {
        NavigationView {
            ZStack {
                Group {
                    Rectangle().foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    RadialGradient(colors: [.clear, colorScheme == .dark ? Color.white : Color.black],
                                   center: .center,
                                   startRadius: 1,
                                   endRadius: 5)
                        .opacity(0.6)
                }
                .opacity(0.4)
                .blur(radius: 2)
                .cornerRadius(20)
                .frame(width: width, height: height)
                .shadow(radius: 30)

                VStack {
                    if signinField {
                        TextField("Email", text: $email)
                            .textFieldStyle(.roundedBorder)
                            .padding()
                        SecureField("Password", text: $password)
                            .textFieldStyle(.roundedBorder)
                            .padding()
                    }

                    if signupField {
                        TextField("Email", text: $email)
                            .textFieldStyle(.roundedBorder)
                            .padding()
                        SecureField("Password", text: $password)
                            .textFieldStyle(.roundedBorder)
                            .padding()
                        SecureField("Confirm Password", text: $confirmPassword)
                            .textFieldStyle(.roundedBorder)
                            .padding()
                    }
                    if signin {
                        Button("Sign in") {
                            withAnimation {
                                signup = false
                                signinField = true
                                backwards = true
                                height = signin ? 500 : 300  // Adjust height depending on content displayed
                                width = 400
                            }
                        }
                        .buttonStyle(.bordered)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                    }

                    if signup {
                        Button("Sign up") {
                            withAnimation {
                                width = 400
                                signupField = true
                                backwards = true
                                signin = false
                                height = signup ? 500 : 300  // Adjust height depending on content displayed
                            }
                        }
                        .buttonStyle(.bordered)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                        .frame(width: 350)
                    }

                    if backwards {
                        Button("Back") {
                            withAnimation {
                                self.navigateToITranslator = true
                                width = 200
                                height = 250
                                signinField = false
                                signupField = false
                                signin = true
                                signup = true
                                backwards = false
                                //                        signup.toggle()  // Toggle to allow re-opening if closed
                                //height = signup ? 500 : 300  // Adjust height depending on content displayed
                            }
                        }
                        .buttonStyle(.bordered)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                        .frame(width: 350)
                    }

                }
                .frame(width: width)
            }
            .navigationBarHidden(true) // Hide navigation bar for this view
            
            // This NavigationLink should navigate to ItranslatorView when navigateToITranslator becomes true
            NavigationLink(
                destination: ItranslatorView(viewModel: ItranslatorViewModel()),
                isActive: $navigateToITranslator,
                label: { EmptyView() }
            )
        }
    }
}



//struct GlassBackGround: View {
//    @Environment(\.colorScheme) var colorScheme
//
//    @State var width: CGFloat = 250
//    @State var height: CGFloat = 250  // Adjusted for better initial fit
//    @State var signin: Bool = true
//    @State var signup: Bool = true
//    @State var signinField: Bool = false
//    @State var signupField: Bool = false
//    @State var backwards: Bool = false
//    @State private var email: String = ""
//    @State private var navigateToITranslator: Bool = false
//    @State private var password: String = ""
//    @State private var confirmPassword: String = ""
//
//    var body: some View {
//        NavigationView {
//            ZStack {
//                Group {
//                    
//                    Rectangle().foregroundColor(colorScheme == .dark ? Color.white : Color.black)
//                    RadialGradient(colors: [.clear, colorScheme == .dark ? Color.white : Color.black],
//                                   center: .center,
//                                   startRadius: 1,
//                                   endRadius: 5)
//                    .opacity(0.6)
//                }
//                .opacity(0.4)
//                .blur(radius: 2)
//                .cornerRadius(20)
//                .frame(width: width, height: height)
//                .shadow(radius: 30)
//                
//                VStack {
//                    
//                    
//                    if signinField {
//                        TextField("Email", text: $email)
//                            .textFieldStyle(.roundedBorder)
//                            .padding()
//                        SecureField("Password", text: $password)
//                            .textFieldStyle(.roundedBorder)
//                            .padding()
//                    }
//                    
//                    if signupField {
//                        TextField("Email", text: $email)
//                            .textFieldStyle(.roundedBorder)
//                            .padding()
//                        SecureField("Password", text: $password)
//                            .textFieldStyle(.roundedBorder)
//                            .padding()
//                        SecureField("Confirm Password", text: $confirmPassword)
//                            .textFieldStyle(.roundedBorder)
//                            .padding()
//                    }
//                    if signin {
//                        Button("Sign in") {
//                            withAnimation {
//                                signup = false
//                                signinField = true
//                                backwards = true
//                                height = signin ? 500 : 300  // Adjust height depending on content displayed
//                                width = 400
//                            }
//                        }
//                        .buttonStyle(.bordered)
//                        .foregroundColor(.white)
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                    }
//                    
//                    
//                    if signup {
//                        Button("Sign up") {
//                            withAnimation {
//                                width = 400
//                                signupField = true
//                                backwards = true
//                                signin = false
//                                height = signup ? 500 : 300  // Adjust height depending on content displayed
//                            }
//                        }
//                        .buttonStyle(.bordered)
//                        .foregroundColor(.white)
//                        .background(Color.green)
//                        .cornerRadius(10)
//                        .frame(width: 350)
//                    }
//                    
//                    
//                    if backwards {
//                        Button("Back") {
//                            withAnimation {
//                                self.navigateToITranslator = true
//                                width = 200
//                                height = 250
//                                signinField = false
//                                signupField = false
//                                signin = true
//                                signup = true
//                                backwards = false
//                                //                        signup.toggle()  // Toggle to allow re-opening if closed
//                                //height = signup ? 500 : 300  // Adjust height depending on content displayed
//                            }
//                        }
//                        .buttonStyle(.bordered)
//                        .foregroundColor(.white)
//                        .background(Color.green)
//                        .cornerRadius(10)
//                        .frame(width: 350)
//                    }
//                    
//                }
//                .frame(width: width)
//                
//                
//            }
//        }
//        NavigationLink(destination: ItranslatorView(viewModel: ItranslatorViewModel()), isActive: $navigateToITranslator))
//        
//    }
//}
