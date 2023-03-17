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
        //tabBarController?.tabBar.isHidden = true
        setupImageView()
        updateUI()
    }
    
    // MARK: - Actions
     
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let title = postTitleTextField.text,
              let body = postBodyTextField.text,
        let image = postImageView.image else
        { return }
    
        viewModel.save(title: title, body: body, image: image)
    }
    
    private func updateUI () {
        guard let post = viewModel.post else { return }
        postTitleTextField.text = post.postTitle
        postBodyTextField.text = post.postBody
        postDateLabel.text = post.postDate.stringValue()
        
        viewModel.getImage { image in
            self.postImageView.image = image
        }
    }
    
    func setupImageView() {
        postImageView.contentMode = .scaleAspectFit
        postImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        postImageView.addGestureRecognizer(tapGesture)
    }
                                                
    @objc func imageViewTapped() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
}

// MARK: - Extension
extension PostDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        postImageView.image = image
    }
}

// MARK: - PostDetailViewModelDelegate
extension PostDetailViewController: PostDetailViewModelDelegate {
    func imageSuccessfullySaved() {
        self.navigationController?.popViewController(animated: true)
    }
}
