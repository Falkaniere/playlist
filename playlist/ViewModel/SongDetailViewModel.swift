//
//  SongDetailViewModel.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 05/05/23.
//

import Foundation

class SongDetailViewModel {
    private let firebaseService = FirebaseService()
    
    func updateSongById(song: PlaylistModel.Song, completion: @escaping (Bool?) -> Void) {
        FirebaseService().updateSong(updatedSong: song) { result in
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
