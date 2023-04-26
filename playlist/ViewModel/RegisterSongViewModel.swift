//
//  RegisterSongViewModel.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 03/02/23.
//


import SwiftUI
import Firebase

class RegisterSongViewModel: ObservableObject {
    
    let firebase = FirebaseService()
    
    func registerNewSong(nameOfSong: String, rhythm: String, completion: @escaping (Bool?) -> Void) {
        if nameOfSong.isEmpty {
            print("document inválido")
            completion(nil)
        } else {
            firebase.createNewSong(nameSong: nameOfSong, rhythm: rhythm) { result in
                switch result {
                case .success(_):
                    completion(true)
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(false)
                }
            }
        }
    }
    
}
