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
    func getIsLoggedIn() -> Bool
}
