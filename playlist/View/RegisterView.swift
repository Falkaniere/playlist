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
                
                Text("Preencha o formulário abaixo")
                
                Form {
                    Section(header: Text("Nome")) {
                        TextField("Nome", text: $userName)
                    }
                    Section(header: Text("Email")) {
                        TextField("Email", text: $userEmail)
                    }
                    Section(header: Text("Igreja")) {
                        TextField("Igreja", text: $userChurch)
                    }
                    Section(header: Text("Senha")) {
                        TextField("Senha", text: $userPassword)
                    }
                    Section(header: Text("Confirme a senha")) {
                        TextField("Confirme a senha", text: $confirmUserPassword)
                    }
                }
                
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
                .disabled(userName.isEmpty || userEmail.isEmpty || userChurch.isEmpty || userPassword.isEmpty || confirmUserPassword.isEmpty)
            }
            .navigationTitle("Cadastro")
            .navigationBarTitleDisplayMode(.inline)
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
