import SwiftUI

struct RegisterView: View {
    
    @ObservedObject private var viewModel = RegisterUserViewModel()
    
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
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .keyboardType(.default)
                
                TextField("Email", text: $userEmail)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                TextField("Igreja", text: $userChurch)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Senha", text: $userPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Confirme a senha", text: $confirmUserPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Spacer()
                
                Button("Cadastrar") {
                    if(userPassword == confirmUserPassword) {
                        viewModel.register(name: userName, email: userEmail, church: userChurch, password: userPassword) { user in
                            print("User registered successfully: \(user)")
                            passwordNotMatches = false
                            isRegistrationSuccessful = true
                        } onFailure: { error in
                            print("Registration error: \(error.localizedDescription)")
                            viewModel.showError = true
                        }
                    } else {
                        passwordNotMatches = true
                    }
                }
                .padding()
                .buttonStyle(FilledButtonStyle(disabled: userName.isEmpty || userEmail.isEmpty || userChurch.isEmpty || userPassword.isEmpty || confirmUserPassword.isEmpty))
                
                Spacer()
            }
            .navigationTitle("Cadastro")
        }
        .alert("Senhas diferentes!", isPresented: $passwordNotMatches){
            Button("OK"){
                passwordNotMatches = false
            }
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
        }

        NavigationLink(
            destination: LoginView(),
            isActive: $isRegistrationSuccessful,
            label: EmptyView.init
        )
        .hidden()
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

struct FilledButtonStyle: ButtonStyle {
    var disabled: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(disabled ? Color.gray : CustomColor.colorSystem)
            .cornerRadius(20)
            .opacity(disabled ? 0.5 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1))
    }
}
