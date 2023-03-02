//
//  ContentView.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 23/01/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var firestoreManager: PlaylistViewModel
    @ObservedObject var viewModel = PlaylistViewModel()
    @State private var textToSearch = ""
    
    var body: some View {
        NavigationView {
            VStack{
                List{
                    ForEach(listWithSearch, id: \.id, content: { song in
                        VStack{
                            Text(song.title)
                        }
                    }).onDelete(perform: viewModel.deleteSongByID(at:))
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Text("Músicas")
                        .font(.largeTitle.bold())
                        .accessibilityAddTraits(.isHeader)
                        .padding(.bottom)
                }
                ToolbarItem(placement: .automatic){
                    NavigationLink(destination: RegisterSong()){
                        Image(systemName: "plus.circle")
                            .font(.system(size: 22, weight: .light))
                            .padding(.bottom)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .searchable(text: $textToSearch,
                        placement: .navigationBarDrawer(displayMode: .always))
            .onAppear(){
                self.viewModel.getAllSongs()
            }
        }
    }
    
    var listWithSearch: [PlaylistModel.Song] {
        if textToSearch.isEmpty {
            return viewModel.listOfSongs
        } else {
            return viewModel.listOfSongs.filter{($0.title).contains(textToSearch)}
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let playListViewModel = PlaylistViewModel()
        
        ContentView(viewModel: playListViewModel)
            .environmentObject(PlaylistViewModel())
    }
}
