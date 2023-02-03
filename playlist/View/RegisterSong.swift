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
    @State private var isPresentingSuccessAlert: Bool = false
    @State private var isPresentingErrorAlert: Bool = false

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
                    let result = registerSongViewModel.registerNewSong(nameOfSong: nameOfSong)
                    if result == true {
                        isPresentingSuccessAlert = true
                    } else {
                        isPresentingErrorAlert = true
                    }
                }) {
                    Text("Enviar")
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
        .alert("Música nova adicionada!", isPresented: $isPresentingSuccessAlert){
            Button("OK"){
                nameOfSong = ""
                isPresentingSuccessAlert = false
            }
        }
        .alert("Algo de errado não está certo 🤔, tenta de novo daqui a pouco!", isPresented: $isPresentingErrorAlert) {
            Button("Voltar"){
                isPresentingErrorAlert = false
            }
        }
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
