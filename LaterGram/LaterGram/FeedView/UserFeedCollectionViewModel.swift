//
//  UserFeedCollectionViewModel.swift
//  LaterGram
//
//  Created by Jake Gloschat on 3/17/23.
//

import Foundation

protocol UserFeedCollectionViewModelDelegate: AnyObject {
    func postsLoadedSuccessfully()
}

class UserFeedCollectionViewModel {
    
    
    // MARK: - Properties
    var posts: [Post] = []
    private var service: FirebaseSyncable
    private weak var delegate: UserFeedCollectionViewModelDelegate?
    
    init(firebaseService: FirebaseSyncable = Firebaseservice(), delegate: UserFeedCollectionViewModelDelegate) {
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
}
