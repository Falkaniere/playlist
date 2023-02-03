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
    
    var body: some View {
        NavigationView{
            VStack{
                Header()
                List{
                    ForEach(viewModel.listOfSongs, id: \.self, content: { song in
                        VStack{
                            Text(song.title)
                        }
                    })
                }
            }
            
            .padding(.init(top: 40, leading: 0, bottom: 0, trailing: 0))
            .ignoresSafeArea()
            .listStyle(PlainListStyle())
            .onAppear(){
                self.viewModel.getAllSongs()
            }
        }
    }
}

struct Header: View {
    var body: some View {
        HStack{
            Text("Músicas")
                .bold()
                .padding(.leading)
                .font(.custom("Avenir Book", size: 28))
            Spacer()
            NavigationLink(destination: RegisterSong()){
                Image(systemName: "plus.circle")
                    .font(.system(size: 25, weight: .light))
                    .padding(.trailing)
            }
        }
        .padding(.init(top: 50, leading: 0, bottom: 0, trailing: 0))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let playListViewModel = PlaylistViewModel()
        
        ContentView(viewModel: playListViewModel)
            .environmentObject(PlaylistViewModel())
    }
}
