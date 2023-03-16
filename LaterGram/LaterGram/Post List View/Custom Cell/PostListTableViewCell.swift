//
//  PostListTableViewCell.swift
//  LaterGram
//
//  Created by Jake Gloschat on 3/14/23.
//

import UIKit

class PostListTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var postImageView: ServiceRequestingImageView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    
    // MARK: - Properties
   
    
    // MARK: - Helper Functions
    func configureCell(with post: Post) {
        postTitleLabel.text = post.postTitle
        postBodyLabel.text = post.postBody
        fetchImage(with: post)
    }
    func fetchImage(with post: Post) {
        postImageView.fetchImage(using: post)
    }
}


