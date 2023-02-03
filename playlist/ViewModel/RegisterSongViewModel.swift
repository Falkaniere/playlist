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
    
    func registerNewSong(nameOfSong: String) {
        if nameOfSong.isEmpty {
            print("document inválid")
            return
        } else {
            firebase.createNewSong(nameSong: nameOfSong)
        }
    }
    
}
