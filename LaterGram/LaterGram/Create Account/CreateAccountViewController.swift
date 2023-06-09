//
//  CreateAccountViewController.swift
//  LaterGram
//
//  Created by Jake Gloschat on 3/16/23.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var userConfirmPasswordTextField: UITextField!
    
    // MARK: - Properties
    var viewModel: CreateAccountViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CreateAccountViewModel()
    }
    
    // MARK: - Action
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        guard let email = userEmailTextField.text,
              let password = userPasswordTextField.text,
              let confirmPassword = userConfirmPasswordTextField.text else { return }
        
        viewModel.createAccount(email: email, password: password, confrimPassword: confirmPassword)
        self.navigationController?.popViewController(animated: true)
    }
}
