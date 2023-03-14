//
//  PostViewModel.swift
//  LaterGram
//
//  Created by Jake Gloschat on 3/13/23.
//

import UIKit
import FirebaseFirestore

struct PostDetailViewModel {
    
    // MARK: - Properties
    var post: Post?
    let service: FirebaseSyncable // removes concrete type
    init(post: Post? = nil, serviceInjected: FirebaseSyncable = Firebaseservice()) {
        self.post = post
        service = serviceInjected
    }
    
    func save(title: String, body: String) {
        if post != nil {
            updatePost(with: title, body: body)
        } else {
            let post = Post(postTitle: title, postBody: body)
            service.save(post: post)
        }
    }
    
    private func updatePost(with title: String, body: String) {
        guard let post = post else { return }
        post.postTitle = title
        post.postBody = body
        service.save(post: post)
    }
}
