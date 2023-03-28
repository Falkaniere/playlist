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
    
    let playListViewModel = PlaylistViewModel()
    
    @StateObject var firestoreManager = PlaylistViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(firestoreManager)
        }
    }
}
