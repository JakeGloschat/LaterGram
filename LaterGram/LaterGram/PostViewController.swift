//
//  PostViewController.swift
//  LaterGram
//
//  Created by Jake Gloschat on 3/13/23.
//

import UIKit

class PostViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var postTitleTextField: UITextField!
    @IBOutlet weak var postBodyTextField: UITextView!
    @IBOutlet weak var addButtonLabel: UIButton!
    
    // MARK: - Properties
    var viewModel: PostViewModel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PostViewModel()
        
    }
    
    
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let title = postTitleTextField.text,
              let body = postBodyTextField.text else { return }
        
        viewModel.save(title: title, body: body)
     //   self.navigationController?.popViewController(animated: true)
    }
    
}
