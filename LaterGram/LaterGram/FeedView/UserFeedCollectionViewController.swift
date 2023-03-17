//
//  UserFeedCollectionViewController.swift
//  LaterGram
//
//  Created by Jake Gloschat on 3/17/23.
//

import UIKit


class UserFeedCollectionViewController: UICollectionViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = UserFeedCollectionViewModel(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadData()
    }
    
    // MARK: - Properties
    var viewModel: UserFeedCollectionViewModel!
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        
        if let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedCell", for: indexPath) as? UserFeedCollectionViewCell {
            
            feedCell.configureCell(with: viewModel.posts[indexPath.row])
            
            cell = feedCell
        }
        
        return cell
    }
    
}

extension UserFeedCollectionViewController: UserFeedCollectionViewModelDelegate {
    func postsLoadedSuccessfully() {
        collectionView.reloadData()
    }
}
