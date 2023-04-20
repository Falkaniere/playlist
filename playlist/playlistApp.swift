//
//  playlistApp.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 23/01/23.
//

import SwiftUI
import Firebase

@main
struct playlistApp: App {
    init(){
        FirebaseApp.configure()
    }
    
    let playListViewModel = PlaylistViewModel()
    
    @StateObject var firestoreManager = PlaylistViewModel()
    

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(firestoreManager)
        }
    }
}
