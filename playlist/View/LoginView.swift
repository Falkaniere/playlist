
import SwiftUI

struct CustomColor {
    static let colorSystem = Color("systemColor")
    static let googleColor = Color("googleColor")
    static let appleColor = Color("appleColor")
}

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    @State private var isSecurePassword = true
    @State private var email = ""
    @State private var password = ""
    @State private var isLoginSuccessful = true

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                Image("Image")

                VStack(alignment: .leading) {
                    TextField("Email", text: $email)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 16)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                        .padding(.horizontal, 16)

                    if isSecurePassword {
                        SecureField("Password", text: $password)
                            .textInputAutocapitalization(.never)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 16)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                            .padding(.horizontal, 16)
                    } else {
                        TextField("Password", text: $password)
                            .textInputAutocapitalization(.never)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 16)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                            .padding(.horizontal, 16)
                    }

                    Button(action: {
                        viewModel.login(email: email, password: password) { success in
                            isLoginSuccessful = success
                        }
                    }) {
                        Text("Entrar")
                            .bold()
                            .foregroundColor(.black)
                    }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(CustomColor.colorSystem)
                    .cornerRadius(20)
                    .padding()

                    NavigationLink(destination: RegisterView()) {
                        Text("Novo por aqui? Cadastre-se")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }

                Spacer()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .alert(isPresented: Binding<Bool>(get: { isLoginSuccessful == false }, set: { _ in })) {
            Alert(title: Text("Erro!"), message: Text("Email ou senha inválido(s)"))
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
