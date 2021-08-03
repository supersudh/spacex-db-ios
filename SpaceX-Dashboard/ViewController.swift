//
//  ViewController.swift
//  SpaceX-Dashboard
//
//  Created by Sudharsan Ravikumar on 02/08/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userTextField.layer.cornerRadius = 22
        passwordTextField.layer.cornerRadius = 22
        signinButton.layer.cornerRadius = 22
        userTextField.delegate = self
        passwordTextField.delegate = self
    }

    @IBAction func onAttemptLogin(_ sender: Any) {
        
        self.view.endEditing(true)
        var hasSatisfiedLoginConditions = false
        guard let username = userTextField.text, let password = passwordTextField.text else { return  }
        
        let rawUserName = username.trimmingCharacters(in: .whitespaces)
        let rawPassword = password.trimmingCharacters(in: .whitespaces)
        
        if rawUserName.count > 0 && rawPassword.count > 0 {
            let isValidUser = AppUserDefaults.checkValidUser(username: username, password: password)
            hasSatisfiedLoginConditions = isValidUser
            if hasSatisfiedLoginConditions {
                print("HERE!!!")
                AppUserDefaults.saveLoggedInUserData(username: username)
                guard (self.storyboard?.instantiateViewController(identifier: "drawerContainer")) != nil
                else { print("no such viewcontroller")
                    return
                }
                let objAppDelegate = UIApplication.shared.delegate as? AppDelegate
                objAppDelegate?.manageFirstScreen()
            } else {
                showError(message: "Username and password does not match.")
            }
        } else {
            showError(message: "Please add Username and password")
        }
    }
    
    private func showError(message: String) {
        errorLabel.text = message
    }
}
extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorLabel.text = ""
    }
}

