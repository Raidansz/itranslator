//
//  AuthManager.swift
//  Itranslator
//
//  Created by Raidan on 20/04/2024.
//

import Foundation
import Combine
import FirebaseAuth

class SessionManager: ObservableObject,SessionManagerProtocol {
    
    
    @Published var isLoggedIn: Bool = false
    
    var authHandle: AuthStateDidChangeListenerHandle?
    
    init() {
        authHandle = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            self?.isLoggedIn = user != nil
        }
    }
    func getIsLoggedIn() -> Bool {
        return isLoggedIn
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
        } catch {
            print("Error signing out")
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                print(error)
                completion(false) // Call the completion handler with false indicating sign-in failure
            } else {
                print("ok")
                completion(true) // Call the completion handler with true indicating sign-in success
            }
        }
    }
    
    deinit {
        if let authHandle = authHandle {
            Auth.auth().removeStateDidChangeListener(authHandle)
        }
    }
}


private struct SessionManagerKey: InjectionKey {
    static var currentValue: SessionManagerProtocol  =  SessionManager()
}

extension InjectedValues {
    var sessionManager: SessionManagerProtocol {
        get { Self[SessionManagerKey.self]}
        set { Self[SessionManagerKey.self] = newValue }
    }
}

protocol SessionManagerProtocol {
    func signOut()
    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void)
    func getIsLoggedIn() -> Bool
}
