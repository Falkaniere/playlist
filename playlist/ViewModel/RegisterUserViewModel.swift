//
//  RegisterViewModel.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 18/04/23.
//

import Foundation
import FirebaseAuth
import Firestore

class RegisterUserViewModel: ObservableObject {
    let firebaseService = FirebaseService()

    
    func registerUser(name: String, email: String, church: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        let db = Firestore.firestore()
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                 if let error = error {
                     print("Error creating user: \(error.localizedDescription)")
                 } else if let user = authResult?.user {
                     print("User registered successfully with uid: \(user.uid)")
                     let userData = [
                         "name": name,
                         "church": church
                     ]
                     
                     db.collection("users").document(user.uid).setData(userData) { error in
                         if let error = error {
                             print("Error saving user data: \(error.localizedDescription)")
                         } else {
                             print("User data saved successfully")
                             self.isRegistrationSuccessful = true
                         }
                     }
                 }
             }
    }
}
