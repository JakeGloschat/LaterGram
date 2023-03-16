//
//  FirebaseService.swift
//  LaterGram
//
//  Created by Jake Gloschat on 3/13/23.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

enum FirebaseError: Error {
    case firebaseError(Error)
    case failedToUnwrapData
    case noDataFound
}

protocol FirebaseSyncable {
    func save(title: String, body: String, image: UIImage, completion: @escaping () -> Void)
    func loadPosts(completion: @escaping (Result<[Post], FirebaseError>) -> Void)
    func delete(post: Post)
    func saveImage(_ image: UIImage, with uuidString: String, completion: @escaping (Result<URL, FirebaseError>) -> Void)
    func deleteImage(from post: Post)
    func fetchImage(from post: Post, completion: @escaping (Result<UIImage, FirebaseError>) -> Void)
    func update(_ post: Post, with newImage: UIImage, completion: @escaping () -> Void)
}

struct Firebaseservice: FirebaseSyncable {
    
    // MARK: - Properties
    let ref = Firestore.firestore()
    let storage = Storage.storage().reference()
    
    // MARK: - Functions
    func save(title: String, body: String, image: UIImage, completion: @escaping () -> Void) {
        
        let uuid = UUID().uuidString
        
        saveImage(image, with: uuid) { result in
            switch result {
            case .success(let imageURL):
                let post = Post(postTitle: title, postBody: body, uuid: uuid, imageURL: imageURL.absoluteString)
                ref.collection(Post.Key.collectionType).document(post.uuid).setData(post.dictionaryRepresentation)
                completion()
            case .failure(let failure):
                print(failure)
                return
            }
        }
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
        deleteImage(from: post)
    }
    
    func saveImage(_ image: UIImage, with uuidString: String, completion: @escaping (Result<URL, FirebaseError>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.05) else { return }
        
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = Constants.Post.storageImageRef
        
        let uploadTask = storage.child(Constants.Post.storageImageRef).child(uuidString).putData(imageData, metadata: uploadMetadata) {_, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
                return
            }
        }
        
        uploadTask.observe(.success) { snapshot in
            print("uploaded image")
            storage.child(Constants.Post.storageImageRef).child(uuidString).downloadURL { url, error in
                if let error = error {
                    print(error.localizedDescription)
                    completion(.failure(.firebaseError(error)))
                    return
                }
                
                if let url {
                    print("Image URL: \(url)")
                    completion(.success(url))
                }
            }
        }
        
        uploadTask.observe(.failure) { snapshot in
            completion(.failure(.firebaseError(snapshot.error!)))
            return
        }
    }
    
    func fetchImage(from post: Post, completion: @escaping (Result<UIImage, FirebaseError>) -> Void) {
        storage.child(Constants.Post.storageImageRef).child(post.uuid).getData(maxSize: 1024 * 1024) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { completion(.failure(.failedToUnwrapData)) ; return }
                completion(.success(image))
            case .failure(let error):
                completion(.failure(.firebaseError(error)))
                return
            }
        }
    }
    
    func deleteImage(from post: Post) {
        storage.child(Constants.Post.storageImageRef).child(post.uuid).delete(completion: nil)
    }
    
    func update(_ post: Post, with newImage: UIImage, completion: @escaping () -> Void) {
        saveImage(newImage, with: post.uuid) { result in
            switch result {
            case .success(let imageURL):
                post.imageURL = imageURL.absoluteString
                ref.collection(Post.Key.collectionType).document(post.uuid).setData(post.dictionaryRepresentation)
                completion()
            case .failure(let failure):
                print(failure)
                return
            }
        }
    }
}
