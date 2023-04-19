//
//  FirebaseService.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 03/02/23.
//

import Foundation
import Firebase
import FirebaseAuth

class FirebaseService: ObservableObject {
    
    static let FirebaseShared = FirebaseService()
    
    func deleteSongByID(id: String){
        let db = Firestore.firestore()
        db.collection("songs").whereField("id", isEqualTo: id).getDocuments(){ ( querySnapshot, err ) in
            if let err = err {
                print("SOME ERROR WITH ERROR \(err)")
            } else {
                for document in querySnapshot!.documents {
                    document.reference.delete()
                }
            }
        }
    }
    
    func createNewSong(nameSong: String) -> Bool {
        var ref: DocumentReference? = nil
        var isRecord: Bool = false
        let db = Firestore.firestore()
        ref = db.collection("songs").addDocument(data: ["id": UUID().uuidString, "title": nameSong]) { err in
            if let err = err {
                print("Some error occured here: \(err)")
                isRecord = false
            } else {
                print("Document added with ID: \(ref!.documentID)")
                isRecord = true
            }
        }
        
        return isRecord
    }
    
    func getAllSongs(completion: @escaping( [QueryDocumentSnapshot]) -> Void) {
        let db = Firestore.firestore()
        db.collection("songs").order(by: "title").addSnapshotListener { (querySnapshot, error) in
            if ((querySnapshot?.documents) != nil) {
                return completion(querySnapshot!.documents)
            } else {
                print("No documents")
                return
            }
        }
    }
    
    func authentication(email: String, password: String, completion: @escaping (User ) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard let result = result, error == nil else {
              //handle error
              return
            }
            let user = result.user
            completion(user)
        }
    }
    
    
    func registerUser(name: String, email: String, church: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        let db = Firestore.firestore()
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error creating user: \(error.localizedDescription)")
            } else if let user = authResult?.user {
                print("User registered successfully with uid: \(user.uid)")
                
                let userData = [
                    "name": name,
                    "church": church
                ]
                
                db.collection("users").document(user.uid).setData(userData) { error in
                    if let error = error {
                        print("Error saving user data: \(error.localizedDescription)")
                    } else {
                        print("User data saved successfully")
                        self.isRegistrationSuccessful = true
                    }
                }
            }
        }
    }
}
