//
//  Login.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 11/03/23.
//

import SwiftUI

struct CustomColor {
    static let colorSystem = Color("systemColor")
    static let googleColor = Color("googleColor")
    static let appleColor = Color("appleColor")
}

struct LoginView: View {
    
    @ObservedObject var loginViewModel = LoginViewModel()
    @State private var isSecured: Bool = true
    @State var userEmail: String = ""
    @State var userPassword: String = ""
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Image("Image")
            
            VStack(alignment: .leading){
                Group {
                    TextField("Email", text: $userEmail)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .padding(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.black, lineWidth: 2)
                        }
                        .padding(.horizontal)
                    if isSecured {
                        SecureField("Password", text: $userPassword)
                            .textInputAutocapitalization(.never)
                            .padding(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black, lineWidth: 2)
                            }
                            .padding(.horizontal)
                    } else {
                        TextField("Password", text: $userPassword)
                            .textInputAutocapitalization(.never)
                            .padding(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black, lineWidth: 2)
                            }
                            .padding(.horizontal)
                        
                    }
                    Button {
                        loginViewModel.login(email: userEmail, password: userPassword)
                    } label: {
                        Text("Entrar")
                            .bold()
                            .foregroundColor(.black)
                    }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(CustomColor.colorSystem)
                    .cornerRadius(20)
                    .padding()
                }
              
            }
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
