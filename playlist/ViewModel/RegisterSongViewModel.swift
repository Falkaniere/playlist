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
    
    func registerNewSong(nameOfSong: String, completion: @escaping (Bool?) -> Void) {
        if nameOfSong.isEmpty {
            print("document inválido")
            completion(nil)
        } else {
            firebase.createNewSong(nameSong: nameOfSong) { result in
                switch result {
                case .success(let ref):
                    completion(true)
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(false)
                }
            }
        }
    }
    
}
