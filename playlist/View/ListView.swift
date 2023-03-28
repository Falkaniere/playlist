//
//  ContentView.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 23/01/23.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var loginViewModel = LoginViewModel()
    @EnvironmentObject var firestoreManager: PlaylistViewModel
    @ObservedObject var viewModel = PlaylistViewModel()
    @State private var textToSearch = ""
    
    var body: some View {
        NavigationView {
            VStack{
                List{
                    ForEach(listWithSearch, id: \.id, content: { song in
                        VStack{
                            NavigationLink(destination: SongView(song: song)){
                                Text(song.title)
                            }
                        }
                    }).onDelete(perform: viewModel.deleteSongByID(at:))
                }
                Button{
                    loginViewModel.signOut()
                } label: {
                    Text("SAIR")
                        .bold()
                        .foregroundColor(.blue)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Músicas")
                        .font(.largeTitle.bold())
                        .accessibilityAddTraits(.isHeader)
                        .padding(.bottom)
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink(destination: LoginView()){
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


struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        let playListViewModel = PlaylistViewModel()
        
        ContentView()
            .environmentObject(PlaylistViewModel())
    }
}
