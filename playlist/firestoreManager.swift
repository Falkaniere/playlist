//
//  firestoreManager.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 30/01/23.
//

import Foundation
import Firebase

class FirestoreManager: ObservableObject {
    var allSongsGetFromDB = [Song]()
    
    func getAllSongs() {
        let db = Firestore.firestore();
        
        db.collection("songs").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
//            for document in querySnapshot!.documents {
//                let data = document.data()
//                let title = data["title"] as? String ?? ""
//                let id = data["id"] as? String ?? ""
//                print(title)
//                print(id)
//                self.allSongsGetFromDB.append(Song(title: title, id: id))
//            }
            
            self.allSongsGetFromDB = documents.map { (queryDocumentSnapshot) -> Song in
                let data = queryDocumentSnapshot.data()
                let title = data["title"] as? String ?? ""
                let id = data["id"] as? String ?? ""
//                self.allSongsGetFromDB.append(Song(title: title, id: id))
//                print(self.allSongsGetFromDB)
                return Song(title: title, id: id)
            }
        }
    }
    
    init() {
        getAllSongs()
    }
    
    struct Song: Identifiable {
        var title: String = ""
        var id: String
    }
    
}
