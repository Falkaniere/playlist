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
            VStack{
                Text("or")
                HStack{
                    Button{
                        print("login with google")
                    } label: {
                        Image(systemName: "g.square.fill")
                            .font(.system(size: 35))
                            .foregroundColor(.white)
                        Text("Login with Google")
                            .bold()
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(CustomColor.googleColor)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
//                    Button{
//                        print("login with APPLE")
//                    } label: {                        Image(systemName: "apple.logo")
//                            .font(.system(size: 40))
//                            .foregroundColor(.white)
//                    }
//                    .frame(width: 100, height: 50)
//                    .background(CustomColor.appleColor)
//                    .cornerRadius(10)
//                    .padding()
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
