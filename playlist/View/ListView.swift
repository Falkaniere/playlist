//
//  ContentView.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 23/01/23.
//

import SwiftUI
struct ListView: View {
    @EnvironmentObject var playlistViewModel: PlaylistViewModel
    @StateObject var loginViewModel = LoginViewModel()
    @State private var textToSearch = ""

    var body: some View {
        NavigationView {
            VStack{
                List{
                    ForEach(listWithSearch, id: \.id) { song in
                        NavigationLink(destination: SongView(songData: song)){
                            Text(song.title)
                        }
                    }
                    .onDelete(perform: playlistViewModel.deleteSongByID(at:))
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button{
                        loginViewModel.signOut()
                    } label: {
                        Text("Sair")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink(destination: RegisterSong()){
                        Image(systemName: "plus")
                    }
                }
//                ToolbarItem(placement: .navigationBarTrailing){
//                    NavigationLink(destination: RegisterSong()){
//                        Image(systemName: "line.3.horizontal.decrease.circle")
//                    }
//                }
            }
            .listStyle(PlainListStyle())
            .searchable(text: $textToSearch, placement: .navigationBarDrawer(displayMode: .always))
            .onAppear {
                playlistViewModel.getAllSongs()
            }
            .navigationTitle("Músicas")
            .navigationBarTitleDisplayMode(.large)
            .listStyle(InsetGroupedListStyle())
        }
    }
    
    var listWithSearch: [PlaylistModel.Song] {
        if textToSearch.isEmpty {
            return playlistViewModel.listOfSongs
        } else {
            return playlistViewModel.listOfSongs.filter { $0.title.contains(textToSearch) }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().environmentObject(PlaylistViewModel())
    }
}
