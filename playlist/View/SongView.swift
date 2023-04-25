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
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("Detalhes")
                    .font(.largeTitle.bold())
                    .accessibilityAddTraits(.isHeader)
                    .padding(.leading)
            }
        }
    }
}

struct SongView_Previews: PreviewProvider {
    static var previews: some View {
        SongView(song: PlaylistModel.Song(title: "Test", id: "123"))
    }
}
