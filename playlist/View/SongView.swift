//
//  SongView.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 03/03/23.
//

import SwiftUI

struct SongView: View {
    let songDetailViewModel = SongDetailViewModel()
    
    @State var songData: PlaylistModel.Song
    @State var isDisabledFields = true
    @State var isPresentingSuccessAlert = false
    @State var isSaved = false
    
    var song: PlaylistModel.Song {
        songData
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Nome da música")) {
                    TextField("Title", text: $songData.title)
                        .disabled(isDisabledFields)
                }
                Section(header: Text("Levada (Ritimo Lenta/Rápida)")) {
                    TextField("Levada", text: $songData.rhythm)
                        .autocapitalization(.words)
                        .disabled(isDisabledFields)
                }
                Section(header: Text("Letra")) {
                    if #available(iOS 16.0, *) {
                        TextField("Letra", text: $songData.letterSong, axis: .vertical)
                            .disabled(isDisabledFields)
                    } else {
                        ZStack{
                            TextField("Letra", text: $songData.letterSong)
                                .autocapitalization(.words)
                                .disabled(isDisabledFields)
                                .textInputAutocapitalization(.never)
                        }
                    }
                }
            }
        }
        .alert("Caso você salve as informaçoões serão substituidas, deseja salvar?!", isPresented: $isPresentingSuccessAlert){
            Button("Salvar", role: .destructive){
                songDetailViewModel.updateSongById(song: songData) { result in
                    if result! {
                        isSaved = true
                    } else {
                        isSaved = false
                    }
                }
                isDisabledFields = true
                isPresentingSuccessAlert = false
            }
            Button("Cancelar", role: .cancel) { }
            
        }
        .navigationTitle("Detalhes")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                 isDisabledFields  ?
                Button{
                    isDisabledFields = false
                } label: {
                    Image(systemName: "pencil")
                } :
                Button{
                    isPresentingSuccessAlert = true
                } label: {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

struct SongView_Previews: PreviewProvider {
    static var previews: some View {
        SongView(songData: PlaylistModel.Song(id: "123", title: "Música", rhythm: "Lenta", letterSong: "musica de teste vamos tocar essa musica de teste" ))
    }
}
