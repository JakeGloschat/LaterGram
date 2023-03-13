//
//  PostViewModel.swift
//  LaterGram
//
//  Created by Jake Gloschat on 3/13/23.
//

import UIKit
import FirebaseFirestore

struct PostViewModel {
    
    let service: FirebaseSyncable // removes concrete type
    init(serviceInjected: FirebaseSyncable = Firebaseservice()) {
        service = serviceInjected
    }
    
    func save(title: String, body: String) {
        
        let post = Post(postTitle: title, postBody: body)
        service.save(post: post)
    }
}
