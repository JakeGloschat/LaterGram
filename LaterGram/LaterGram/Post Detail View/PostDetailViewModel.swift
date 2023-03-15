//
//  PostViewModel.swift
//  LaterGram
//
//  Created by Jake Gloschat on 3/13/23.
//

import UIKit
import FirebaseFirestore

protocol PostDetailViewModelDelegate: AnyObject {
    func imageSuccessfullySaved()
}

struct PostDetailViewModel {
    
    // MARK: - Properties
    var post: Post?
    let service: FirebaseSyncable // removes concrete type
    private weak var delegate: PostDetailViewModelDelegate?
    init(post: Post? = nil, serviceInjected: FirebaseSyncable = Firebaseservice(), delegate: PostDetailViewModelDelegate) {
        self.post = post
        service = serviceInjected
        self.delegate = delegate
    }
    
    func save(title: String, body: String, image: UIImage) {
        if let post = post {
            post.postTitle = title
            post.postBody = body
            service.update(post, with: image) {
                self.delegate?.imageSuccessfullySaved()
            }
        } else {
            service.save(title: title, body: body, image: image) {
                self.delegate?.imageSuccessfullySaved()
            }
        }
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
