//
//  PostViewController.swift
//  LaterGram
//
//  Created by Jake Gloschat on 3/13/23.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var postTitleTextField: UITextField!
    @IBOutlet weak var postBodyTextField: UITextView!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    
    // MARK: - Properties
    var viewModel: PostDetailViewModel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        //viewModel = PostDetailViewModel()
        
    }
    
    
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    // MARK: - Actions
     
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = postTitleTextField.text,
              let body = postBodyTextField.text,
        let image = postImageView.image else { return }
    
        viewModel.
        self.navigationController?.popViewController(animated: true)
    }
    
    private func updateUI () {
        guard let post = viewModel.post else { return }
        postTitleTextField.text = post.postTitle
        postBodyTextField.text = post.postBody
        postDateLabel.text = post.postDate.stringValue()
    }
    
}
