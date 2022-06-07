//
//  SignInView.Model.swift
//  LiftLog
//
//  Created by MacbookPro on 5/24/22.
//

import Foundation
import Combine
import FirebaseAuth

extension SignInView {
    final class Model: ObservableObject, Identifiable{
            let auth = Auth.auth()
            
            @Published var signedIn = false
            
            var isSignedIn: Bool {
                return auth.currentUser != nil
            }
            func signIn(email: String, password: String) {
                print("signing In")
                auth.signIn(withEmail: email,
                            password: password) { [weak self] result, error in
                    guard result != nil, error == nil else {
                        print("error")
                        return
                    }
                    DispatchQueue.main.async {
                    // Success
                    self?.signedIn = true
                    }
                }
            }
            
            func signUp(email: String, password: String) {
                auth.createUser(withEmail: email, password: password) { [weak self] result, error in
                    guard result != nil, error == nil else {
                        return
                    }
                    DispatchQueue.main.async {
                    // Success
                    self?.signedIn = true
                    }
                }
            }
                func signOut() {
                    try? auth.signOut()
                    
                    self.signedIn = false
            }
        }

}

