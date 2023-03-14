//
//  PostListTableViewCell.swift
//  LaterGram
//
//  Created by Jake Gloschat on 3/14/23.
//

import UIKit

class PostListTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    
    
    // MARK: - Helper Functions
    func configureCell(with post: Post) {
        postImageView.image = post.postImage
        postTitleLabel.text = post.postTitle
        postBodyLabel.text = post.postBody
    }
}
