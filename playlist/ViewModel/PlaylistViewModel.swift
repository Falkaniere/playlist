//

//  playlistViewModel.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 24/01/23.
//

import SwiftUI

class PlaylistViewModel: ObservableObject {

    private let firebaseService = FirebaseService()
    
    @Published var listOfSongs: [PlaylistModel.Song] = []

    func getAllSongs() {
        firebaseService.getAllSongs { [weak self] result in
            switch result {
            case .success(let documents):
                self?.listOfSongs = documents.compactMap { queryDocumentSnapshot in
                    do {
                        let data = try JSONSerialization.data(withJSONObject: queryDocumentSnapshot.data())
                        let decoder = JSONDecoder()
                        let song = try decoder.decode(PlaylistModel.Song.self, from: data)
                        return song
                    } catch {
                        print("Error decoding song: \(error)")
                        return nil
                    }
                }
            case .failure(let error):
                print("Error getting documents: \(error)")
            }
        }
    }
    
    func deleteSongByID(at offsets: IndexSet) {
        for index in offsets {
            let theItem = listOfSongs[index]
            firebaseService.deleteSongByID(id: theItem.id)
        }
    }
}
