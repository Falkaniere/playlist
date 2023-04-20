//

//  playlistViewModel.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 24/01/23.
//

import SwiftUI

class PlaylistViewModel: ObservableObject {

    let firebaseService = FirebaseService()
    @Published var listOfSongs = [PlaylistModel.Song]()
    
    func getAllSongs() {
        firebaseService.getAllSongs() { result in
            switch result {
            case .success(let documents):
                self.listOfSongs = documents.compactMap { (queryDocumentSnapshot) -> PlaylistModel.Song? in
                    let data = queryDocumentSnapshot.data()
                    let title = data["title"] as? String ?? ""
                    let id = data["id"] as? String ?? ""
                    return PlaylistModel.Song(title: title, id: id)
                }
            case .failure(let error):
                print("Error getting documents: \(error)")
            }
        }
    }
    
    func deleteSongByID(at offsets: IndexSet) -> Void {
        for index in offsets.makeIterator() {
            let theItem = listOfSongs[index]
            firebaseService.deleteSongByID(id: theItem.id)
        }
    }
}