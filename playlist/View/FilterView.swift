//
//  FilterView.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 19/07/23.
//

import SwiftUI

struct FilterView: View {
    let songDetailViewModel = SongDetailViewModel()
    @State private var selectedStrength = "Lento"
    var body: some View {
        ZStack {
            Picker("Ritmo", selection: $selectedStrength) {
                ForEach(songDetailViewModel.strengths, id: \.self) {
                    Text($0)
                }
            }
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}
