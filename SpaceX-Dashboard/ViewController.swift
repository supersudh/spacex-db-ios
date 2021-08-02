//
//  ViewController.swift
//  SpaceX-Dashboard
//
//  Created by Sudharsan Ravikumar on 02/08/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userTextField.layer.cornerRadius = 22
        passwordTextField.layer.cornerRadius = 22
        signinButton.layer.cornerRadius = 22
    }

    @IBAction func onAttemptLogin(_ sender: Any) {
        let hasSatisfiedLoginConditions = true
        if hasSatisfiedLoginConditions {
            print("HERE!!!")
            let mpvc = MainPageViewController()
            self.navigationController?.pushViewController(mpvc, animated: true)
        } else {
            print("Wait...")
        }
    }
    
}

