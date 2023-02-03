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
    
    
    func createNewSong(nameSong: String) {
        let db = Firestore.firestore()
        db.collection("songs").addDocument(data: ["title": nameSong]) { err in
            if let err = err {
                print( "Some error occured here: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
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
