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
                let id = data["id"] as? String ?? ""
                return PlaylistModel.Song(title: title, id: id)
            }
        }
    }
    
    func deleteSongByID(at offsets: IndexSet) -> Void {
        for index in offsets.makeIterator() {
            let theItem = listOfSongs[index]
            let deleteItem = firebaseService.deleteSongByID(id: theItem.id)
            return deleteItem ? true : false
        }
    }
}
