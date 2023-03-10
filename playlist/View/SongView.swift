//
//  SongView.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 03/03/23.
//

import SwiftUI

struct SongView: View {
    @State var song: PlaylistModel.Song
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Nome da musica")) {
                        TextField("Título", text: $song.title )
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
}

struct SongView_Previews: PreviewProvider {
    static var previews: some View {
        
        SongView(song: PlaylistModel.Song(title: "Teste", id: "123"))
    }
}
