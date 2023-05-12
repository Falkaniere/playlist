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
    @State var letterSong: String = ""
    @State var keyWord: String = ""
    @State private var isPresentingSuccessAlert: Bool = false
    @State private var isPresentingErrorAlert: Bool = false
    @State private var selectedStrength = "Lento"
    let strengths = ["Lento", "Rápido"]
    
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
                Picker("Ritmo", selection: $selectedStrength) {
                    ForEach(strengths, id: \.self) {
                        Text($0)
                    }
                }
                Section(header: Text("Letra da música")) {
                    if #available(iOS 16.0, *) {
                        TextField("Title", text: $letterSong,  axis: .vertical)
                            .textInputAutocapitalization(.never)
                    } else {
                        ZStack{
                            TextField("Title", text: $letterSong)
                                .textInputAutocapitalization(.never)
                        }
                    }
                }
//                TO BE DONE
//                Section(header: Text("Palavras chave")) {
//                    TextField("Santa Ceia, Dízimo...", text: $keyWord)
//                }
            }
            Spacer()
            HStack {
                Button(action: {
                    Task {
                        registerSongViewModel.registerNewSong(nameOfSong: nameOfSong, rhythm: selectedStrength, letterSong: letterSong) { result in
                            if let success = result, success == true {
                                isPresentingSuccessAlert = true
                            } else {
                                isPresentingErrorAlert = true
                            }
                        }
                    }
                }) {
                    Text("Enviar")
                }
                .disabled(nameOfSong.isEmpty)
            }
            .padding()
        }
        .navigationBarHidden(true)
        .alert("Música nova adicionada!", isPresented: $isPresentingSuccessAlert){
            Button("OK"){
                nameOfSong = ""
                keyWord = ""
                selectedStrength = "Lento"
                letterSong = ""
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
