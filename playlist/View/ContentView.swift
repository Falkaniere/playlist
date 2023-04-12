//
//  ContentView.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 23/01/23.
//

import SwiftUI

struct ContentView: View {
        @State var isAuthenticated = AppManager.isAuthenticated()
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack{
            if self.isActive{
                Group {
                    isAuthenticated ? AnyView(ListView()) : AnyView(LoginView())
                }
                .onReceive(AppManager.Authenticated, perform: {
                    isAuthenticated = $0
                })
            } else {
                SplashScreenView()
            }
        }.onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
