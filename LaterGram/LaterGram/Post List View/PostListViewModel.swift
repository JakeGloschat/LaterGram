//
//  PostListViewModel.swift
//  LaterGram
//
//  Created by Jake Gloschat on 3/14/23.
//

import Foundation

protocol PostListViewModelDelegate: AnyObject {
    func postsLoadedSuccessfully()
}

class PostListViewModel {
    
    // MARK: - Properties
    var posts: [Post] = []
    private var service: FirebaseSyncable
    private weak var delegate: PostListViewModelDelegate?
    // dependency injection
    init(firebaseService: FirebaseSyncable = Firebaseservice(), delegate: PostListViewModelDelegate) {
        self.service = firebaseService
        self.delegate = delegate
    }
    
    // MARK: - Functions
    func loadData() {
        service.loadPosts { [weak self] result in
            switch result {
            case .success(let posts):
                self?.posts = posts
                self?.delegate?.postsLoadedSuccessfully()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func delete(index: Int) {
        let post = posts[index]
        service.delete(post: post)
        self.posts.remove(at: index)
    }
}
