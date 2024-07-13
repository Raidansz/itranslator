//
//  ItranslatorApp.swift
//  Itranslator
//
//  Created by Raidan on 12/04/2024.
//

import SwiftUI
import FirebaseCore

import FirebaseAuth
@main
struct ItranslatorApp: App {
    @Injected(\.sessionManager) private var sessionManager: SessionManagerProtocol
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            if sessionManager.getIsLoggedIn() {
                ItranslatorView(viewModel: ItranslatorViewModel())
                
            } else {
                LaunchView(viewModel: LaunchViewModel(languagesCount: 30))
               // SwiftUIView()
            }
            
            
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
    
    
}


