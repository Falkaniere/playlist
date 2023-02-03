//

//  playlistViewModel.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 24/01/23.
//

import SwiftUI
import Firebase

class PlaylistViewModel: ObservableObject {

    @Published var listOfSongs = [PlaylistModel.Song]()
    
    func getAllSongs() {
        let db = Firestore.firestore();

        db.collection("songs").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.listOfSongs = documents.map { (queryDocumentSnapshot) -> PlaylistModel.Song in
                let data = queryDocumentSnapshot.data()
                let title = data["title"] as? String ?? ""
                return PlaylistModel.Song(title: title, id: .init())
            }
        }
    }
}
