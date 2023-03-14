//
//  FirebaseService.swift
//  LaterGram
//
//  Created by Jake Gloschat on 3/13/23.
//

import Foundation
import FirebaseFirestore

enum FirebaseError: Error {
    case firebaseError(Error)
    case failedToUnwrapData
    case noDataFound
}

protocol FirebaseSyncable {
    func save(post: Post)
    func loadPosts(completion: @escaping (Result<[Post], FirebaseError>) -> Void)
    func delete(post: Post)
}

struct Firebaseservice: FirebaseSyncable {
    
    let ref = Firestore.firestore()
    
    func save(post: Post) {
        
        ref.collection(Post.Key.collectionType).document(post.uuid).setData(post.dictionaryRepresentation)
    }
    
    func loadPosts(completion: @escaping (Result<[Post], FirebaseError>) -> Void) {
        ref.collection(Post.Key.collectionType).getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
                return
            }
            
            guard let docSnapshotArray = snapshot?.documents else { completion(.failure(.noDataFound)) ; return }
            
            let dictionaryArray = docSnapshotArray.compactMap { $0.data() }
            let post = dictionaryArray.compactMap { Post(fromDictionary: $0)}
            completion(.success(post))
        }
    }
    
    func delete(post: Post) {
        ref.collection(Post.Key.collectionType).document(post.uuid).delete()
    }
}
