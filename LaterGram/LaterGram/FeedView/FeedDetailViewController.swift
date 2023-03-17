//
//  FeedDetailViewController.swift
//  LaterGram
//
//  Created by Jake Gloschat on 3/17/23.
//

import UIKit

class FeedDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    // MARK: - Properties
    var viewModel: FeedDetailViewModel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        guard let post = viewModel.post else { return }
        postTitleLabel.text = post.postTitle
        postBodyLabel.text = post.postBody
        postDateLabel.text = post.postDate.stringValue()
        
        viewModel.getImage { image in
            self.postImageView.image = image
        }
    }
}
// MARK: - PostDetailViewModelDelegate
extension FeedDetailViewController: PostDetailViewModelDelegate {
    func imageSuccessfullySaved() {
        
    }
}
