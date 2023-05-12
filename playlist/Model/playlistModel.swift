//
//  playlistModel.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 24/01/23.
//

import Foundation

struct PlaylistModel {

    struct Song: Hashable, Codable {
        var id: String
        var title: String
        var rhythm: String
        var letterSong: String
    }
}
