//
//  FirebaseService.swift
//  LaterGram
//
//  Created by Jake Gloschat on 3/13/23.
//

import Foundation
import FirebaseFirestore

protocol FirebaseSyncable {
    func save(post: Post)
}

struct Firebaseservice: FirebaseSyncable {
    
    let ref = Firestore.firestore()
    
    func save(post: Post) {
        
        ref.collection("posts").document(post.uuid).setData(post.dictionaryRepresentation)
    }
}
