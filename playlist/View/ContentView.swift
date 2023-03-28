//
//  ContentView.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 23/01/23.
//

import SwiftUI

struct ContentView: View {
    @State var isAuthenticated = AppManager.isAuthenticated()
    
    var body: some View {
        Group {
            isAuthenticated ? AnyView(ListView()) : AnyView(LoginView())
        }
        .onReceive(AppManager.Authenticated, perform: {
            isAuthenticated = $0
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
