//
//  FirebaseService.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 03/02/23.
//

import Foundation
import Firebase

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
}
