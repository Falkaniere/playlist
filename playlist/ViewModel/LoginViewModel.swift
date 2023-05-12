//
//  LoginViewModel.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 17/03/23.
//

import SwiftUI
import FirebaseAuth


class LoginViewModel: ObservableObject {
    let firebaseService = FirebaseService()

    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        firebaseService.authenticate(email: email, password: password) { result in
            switch result {
            case .success:
                let token = UUID().uuidString
                UserDefaults.standard.set(token, forKey: "token")
                AppManager.Authenticated.send(true)
                completion(true)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                completion(false)
            }
        }
    }

    func signOut() {
        try? Auth.auth().signOut()
        UserDefaults.standard.removeObject(forKey: "token")
        AppManager.Authenticated.send(false)
    }
}
