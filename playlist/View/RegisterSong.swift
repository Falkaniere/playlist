//
//  RegisterSong.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 01/02/23.
//

import SwiftUI

struct RegisterSong: View {
    @ObservedObject var registerSongViewModel = RegisterSongViewModel()
    @State var nameOfSong: String = ""
    
    var body: some View {
        VStack{
            HStack{
                BackButton()
                Spacer()
            }
            Form {
                Section(header: Text("Nova música")) {
                    TextField("Titulo", text: $nameOfSong)
                }
            }
            Spacer()
            HStack {
                Button(action: {
                    registerSongViewModel.registerNewSong(nameOfSong: nameOfSong)
                }) {
                    Text("Enviar")
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Text("Voltar")
                    .padding(.leading)
            }
        }
    }
}

struct RegisterSong_Previews: PreviewProvider {
    static var previews: some View {
        RegisterSong()
    }
}
