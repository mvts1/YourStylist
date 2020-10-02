//
//  RegisterViewController.swift
//  YourStylist
//
//  Created by Onur Mavitas on 18.08.2020.
//  Copyright © 2020 Onur Mavitas. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerButton.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        registerButton.layer.cornerRadius = 8
        signInButton.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        signInButton.layer.cornerRadius = 8
    }

    @IBAction func registerPressed(_ sender: Any) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
                   Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                       if let e = error {
                           print(e.localizedDescription)
                       } else {
                           //Navigate to the ChatViewController
                        self.performSegue(withIdentifier: K.registerToWelcomeSegue, sender: self)
                       }
                   }
               }
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
