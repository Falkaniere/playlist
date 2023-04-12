//
//  SplashScreenView.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 11/04/23.
//

import SwiftUI

struct CustomColors {
    static let systemColor = Color("systemColor")
}

struct SplashScreenView: View {
    var body: some View {
        NavigationView {
            ZStack{
                Rectangle()
                    .background(.ultraThinMaterial)
                    .ignoresSafeArea()
                Image("splashImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }.background(CustomColor.colorSystem)
        }
        
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
