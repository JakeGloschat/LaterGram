//
//  SignInViewController.swift
//  LaterGram
//
//  Created by Jake Gloschat on 3/16/23.
//

import UIKit

class SignInViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Properties
    var viewModel: SignInAccountViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = SignInAccountViewModel()
    }
    
// MARK: - Actions
    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        
        viewModel.signInAccount(email: email, password: password)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
