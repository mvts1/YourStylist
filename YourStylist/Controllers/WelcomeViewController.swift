//
//  ViewController.swift
//  YourStylist
//
//  Created by Onur Mavitas on 17.08.2020.
//  Copyright © 2020 Onur Mavitas. All rights reserved.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        signInButton.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        signInButton.layer.cornerRadius = 8
        registerButton.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        registerButton.layer.cornerRadius = 8
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                        self.performSegue(withIdentifier:  K.signInSegue, sender: self)
                    }
                }
            }
        }
    
    @IBAction func registerPressed(_ sender: Any) {
        self.performSegue(withIdentifier: K.registerSegue, sender: self)
    }
}

