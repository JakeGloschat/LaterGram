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
        //configure()
    }
    
    // MARK: - Properties
    var viewModel: UserFeedCollectionViewModel!
    
    // MARK: - Functions
    
//    func configure() {
//          let layout = UICollectionViewFlowLayout()
//          layout.itemSize = CGSize(width: (view.frame.size.width/3)-3,
//                                   height: (view.frame.size.width/3)-3)
//          layout.minimumLineSpacing = 1
//          layout.scrollDirection = .vertical
//          layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
//          layout.minimumInteritemSpacing = 1
//    }
    
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
    
    // MARK: - Navigation
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let destination = segue.destination as? FeedDetailViewController else { return }
//
//        if segue.identifier == "toFeedDetailVC" {
//            guard let indexPath = collectionView.indexPathsForSelectedItems else { return }
//
//
//        }
//    }
    
}

extension UserFeedCollectionViewController: UserFeedCollectionViewModelDelegate {
    func postsLoadedSuccessfully() {
        collectionView.reloadData()
    }
}

