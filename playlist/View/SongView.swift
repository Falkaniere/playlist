//
//  SongView.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 03/03/23.
//

import SwiftUI

struct SongView: View {
    let song: PlaylistModel.Song
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Nome da música")) {
                    TextField("Title", text: .constant(song.title))
                        .disabled(true)
                }
                Section(header: Text("Levada (Ritimo Lenta/Rápida)")) {
                    TextField("Levada", text: .constant(song.rhythm))
                        .autocapitalization(.words)
                        .disabled(true)
                }
                Section(header: Text("Letra")) {
                    if #available(iOS 16.0, *) {
                        TextField("Letra", text: .constant(song.letterSong), axis: .vertical)
                            .disabled(true)
                    } else {
                        ZStack{
                            TextField("Letra", text: .constant(song.letterSong))
                                .autocapitalization(.words)
                                .disabled(true)
                                .textInputAutocapitalization(.never)
                        }
                    }
                }
            }
        }
    }
}

struct SongView_Previews: PreviewProvider {
    static var previews: some View {
        SongView(song: PlaylistModel.Song(id: "123", title: "Música", rhythm: "Lenta", letterSong: "musica de teste vamos tocar essa musica de teste" ))
    }
}
