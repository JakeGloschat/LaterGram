//
//  FeedDetailViewModel.swift
//  LaterGram
//
//  Created by Jake Gloschat on 3/17/23.
//


import UIKit
import FirebaseFirestore

protocol FeedDetailViewModelDelegate: AnyObject {
    func imageSuccessfullySaved()
}

struct FeedDetailViewModel {
    
    // MARK: - Properties
    var post: Post?
    let service: FirebaseSyncable // removes concrete type
    private weak var delegate: FeedDetailViewModelDelegate?
    init(post: Post? = nil, serviceInjected: FirebaseSyncable = Firebaseservice(), delegate: FeedDetailViewModelDelegate) {
        self.post = post
        service = serviceInjected
        self.delegate = delegate
    }
    
    func getImage(completion: @escaping (UIImage?) -> Void) {
        guard let post = post else { return }
        service.fetchImage(from: post) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}

