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

    func login(email: String, password: String) {
        firebaseService.authenticate(email: email, password: password) { result in
            switch result {
            case .success:
                let token = UUID().uuidString
                UserDefaults.standard.set(token, forKey: "token")
                AppManager.Authenticated.send(true)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    func signOut() {
        try? Auth.auth().signOut()
        UserDefaults.standard.removeObject(forKey: "token")
        AppManager.Authenticated.send(false)
    }
}
