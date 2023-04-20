import Foundation
import Firebase

class RegisterUserViewModel: ObservableObject {
    @Published var isValid: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    private let firebaseService = FirebaseService()
    
    func register(name: String, email: String, church: String, password: String, onSuccess: @escaping (User) -> Void, onFailure: @escaping (Error) -> Void) {
        if !name.isEmpty && !email.isEmpty && !password.isEmpty {
            isValid = true
        } else {
            isValid = false
            showError = true
            errorMessage = "Please enter all fields"
            return
        }
        
        firebaseService.registerUser(name: name, email: email, church: church, password: password) { [weak self] result in
            switch result {
            case .success(let user):
                // User data was saved successfully
                print("User data saved successfully")
                onSuccess(user)
            case .failure(let error):
                self?.showError = true
                self?.errorMessage = error.localizedDescription
                onFailure(error)
            }
        }
    }
}
