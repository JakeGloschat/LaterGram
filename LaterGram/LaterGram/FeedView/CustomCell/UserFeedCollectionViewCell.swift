//
//  UserFeedCollectionViewCell.swift
//  LaterGram
//
//  Created by Jake Gloschat on 3/17/23.
//

import UIKit

class UserFeedCollectionViewCell: UICollectionViewCell {
    
   // MARK: - Outlets
    @IBOutlet weak var userFeedImageView: ServiceRequestingImageView!
    
    // MARK: - Functions
    func configureCell(with post: Post) {
        fetchImage(with: post)
    }
    
    func fetchImage(with post: Post) {
        userFeedImageView.fetchImage(using: post)
    }

}
