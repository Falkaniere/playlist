//

//  playlistViewModel.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 24/01/23.
//

import SwiftUI
import Firebase

class PlaylistViewModel: ObservableObject {

    let firebaseService = FirebaseService()
    @Published var listOfSongs = [PlaylistModel.Song]()
    
    func getAllSongs() {
        firebaseService.getAllSongs() { documents in
            self.listOfSongs = documents.map { (queryDocumentSnapshot) -> PlaylistModel.Song in
                let data = queryDocumentSnapshot.data()
                let title = data["title"] as? String ?? ""
                return PlaylistModel.Song(title: title, id: .init())
            }
        }
    }
}
