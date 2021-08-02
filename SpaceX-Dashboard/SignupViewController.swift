//
//  SignupViewController.swift
//  SpaceX-Dashboard
//
//  Created by Sudharsan Ravikumar on 02/08/21.
//

import UIKit

class SignupViewController: UIViewController {
    @IBAction func onNavigateToLogin(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        print("SignupViewController")
    }
}
