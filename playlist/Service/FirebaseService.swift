import Foundation
import Firebase
import FirebaseAuth

final class FirebaseService {
    static let shared = FirebaseService()
    
    
    func deleteSongByID(id: String) {
        let db = Firestore.firestore()
        db.collection("songs").whereField("id", isEqualTo: id).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error while deleting song: \(error.localizedDescription)")
            } else if let documents = querySnapshot?.documents {
                for document in documents {
                    document.reference.delete()
                }
            }
        }
    }
    
    func createNewSong(nameSong: String, rhythm: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let db = Firestore.firestore()
        let songData: [String: Any] = ["id": UUID().uuidString, "title": nameSong, "rhythm": rhythm]
        db.collection("songs").addDocument(data: songData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func getAllSongs(completion: @escaping (Result<[QueryDocumentSnapshot], Error>) -> Void) {
        let db = Firestore.firestore()
        db.collection("songs").order(by: "title").getDocuments { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
            } else if let documents = querySnapshot?.documents {
                completion(.success(documents))
            } else {
                completion(.failure(FirebaseError.noDocumentsFound))
            }
        }
    }
    
    func authenticate(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = authResult?.user {
                completion(.success(user))
            } else {
                completion(.failure(FirebaseError.unknownError))
            }
        }
    }
    
    func registerUser(name: String, email: String, church: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        let db = Firestore.firestore()
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = authResult?.user {
                let userData = ["name": name, "email": email, "church": church]
                db.collection("users").document(user.uid).setData(userData) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(user))
                    }
                }
            } else {
                completion(.failure(FirebaseError.unknownError))
            }
        }
    }
}

enum FirebaseError: Error {
    case noDocumentsFound
    case unknownError
}
