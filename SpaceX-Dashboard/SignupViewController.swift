//
//  SignupViewController.swift
//  SpaceX-Dashboard
//
//  Created by Sudharsan Ravikumar on 02/08/21.
//

import UIKit

class SignupViewController: UIViewController {
   
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    
    override func viewDidLoad() {
        print("SignupViewController")
        txtUserName.delegate = self
        txtPassword.delegate = self
    }
    @IBAction func onNavigateToLogin(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSignUpTapped(_ sender: Any) {
        self.view.endEditing(true)
        guard let username = txtUserName.text, let password = txtPassword.text else { return  }
        
        
        let rawUserName = username.trimmingCharacters(in: .whitespaces)
        let rawPassword = password.trimmingCharacters(in: .whitespaces)

        if rawUserName.count > 0 && rawPassword.count > 0 {
            // check username has first charcter as string
            let isValidUserName = self.isValidUserNameInput(Input: rawUserName)
            
            guard isValidUserName else { return
                showError(message: "Please enter valid username")
            }
            let alredyExistUserName = AppUserDefaults.checkUserNameExist(username: rawUserName)
            if alredyExistUserName {
                print("please choose different username ")
                showError(message: "Please choose different username")
            } else {
                AppUserDefaults.saveSignupUserData(username: username, password: password)
                cleanUp()
                showError(message: "Signup Success")
            }
        } else {
            showError(message: "Please add Username and password")
        }
        
    }
    
    private func showError(message: String) {
        errorLabel.text = message
    }
    func cleanUp() {
        self.txtUserName.text = ""
        self.txtPassword.text = ""
    }
    
    func isValidUserNameInput(Input:String) -> Bool {
        let RegEx = "^[a-zA-Z0-9]*$" //"^[a-zA-Z-]+ ?.* [a-zA-Z-0-9]+$"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: Input)
    }
}
extension SignupViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorLabel.text = ""
    }
}
