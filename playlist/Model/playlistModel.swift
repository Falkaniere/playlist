//
//  playlistModel.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 24/01/23.
//

import Foundation

struct PlaylistModel {

    struct Song: Hashable {
        var id: String
        var title: String
        var rhythm: String
    }
}
