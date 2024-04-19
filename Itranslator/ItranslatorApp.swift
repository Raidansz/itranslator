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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ItranslatorView(viewModel: ItranslatorViewModel())


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
