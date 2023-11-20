//
//  playlistModel.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 24/01/23.
//

import Foundation

struct PlaylistModel: Decodable {

    struct Song: Hashable, Decodable, Encodable {
        var id: String
        var title: String
        var rhythm: String
        var letterSong: String
    }
}
