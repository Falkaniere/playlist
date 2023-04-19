//
//  RegisterView.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 18/04/23.
//

import SwiftUI

struct RegisterView: View {
    
    @ObservedObject private var registerUserViewModel = RegisterUserViewModel()
    
    @State private var passwordNotMatches = false
    @State private var isRegistrationSuccessful = false
    @State private var userName = ""
    @State private var userEmail = ""
    @State private var userChurch = ""
    @State private var userPassword = ""
    @State private var confirmUserPassword = ""

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Preencha o formulário abaixo")
                
                TextField("Nome", text: $userName)
                    .textInputAutocapitalization(.never)
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 2)
                    }
                    .padding(10)
                    .keyboardType(.default)
                
                TextField("Email", text: $userEmail)
                    .textInputAutocapitalization(.never)
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 2)
                    }
                    .padding(10)
                    .keyboardType(.emailAddress)
                
                TextField("Igreja", text: $userChurch)
                    .textInputAutocapitalization(.never)
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 2)
                    }
                    .padding(10)
                
                SecureField("Senha", text: $userPassword)
                    .textInputAutocapitalization(.never)
                    .padding(10)
                    .overlay {
                        passwordNotMatches ?
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.red, lineWidth: 2)
                        :
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 2)
                    }
                    .padding(10)
                
                SecureField("Confirme a senha", text: $confirmUserPassword)
                    .textInputAutocapitalization(.never)
                    .padding(10)
                    .overlay {
                        passwordNotMatches ?
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.red, lineWidth: 2)
                        :
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black  , lineWidth: 2)
                    }
                    .padding(10)
                
                Spacer()
                
                Button {
                    if(userPassword == confirmUserPassword) {
                        passwordNotMatches = false
                        
                        registerUserViewModel.registerUser(name: userName, email: userEmail, church: userChurch, password: userPassword) { result in
                            switch result {
                                case .success(let authResult):
                                    // User registration was successful
                                    print("User registered successfully with uid: \(authResult.user.uid)")
                                    isRegistrationSuccessful = true
                                case .failure(let error):
                                    // User registration failed
                                    print("Error registering user: \(error.localizedDescription)")
                            }
                        }
                    } else {
                        passwordNotMatches = true
                    }
                    
                } label: {
                    Text("Cadastrar")
                        .bold()
                        .foregroundColor(.black)
                }
                .disabled(userName.isEmpty || userEmail.isEmpty || userChurch.isEmpty || userPassword.isEmpty || confirmUserPassword.isEmpty)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(CustomColor.colorSystem)
                .cornerRadius(20)
                .padding()
                
                Spacer()
            }
            .navigationTitle("Cadastro")
        }
        .alert("Senhas diferentes!", isPresented: $passwordNotMatches){
            Button("OK"){
                passwordNotMatches = false
            }
        }
        
        NavigationLink(
             destination: LoginView(),
             isActive: $isRegistrationSuccessful,
             label: {
                 EmptyView()
             })
             .hidden()
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
