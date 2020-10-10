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
    
    let db = Firestore.firestore()

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerButton.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        registerButton.layer.cornerRadius = 8
        signInButton.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        signInButton.layer.cornerRadius = 8
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
    }

    @IBAction func registerPressed(_ sender: Any) {
        if let email = emailTextfield.text, let password = passwordTextfield.text, let username = usernameTextfield.text {
            
            //add the spinner
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            
                   Auth.auth().createUser(withEmail: email, password: password) { user, error in
                       if let e = error {
                           print(e.localizedDescription)
                       } else {
                        
                        guard let userId = user?.user.uid else { return }
                        var user_type = "Standard"
                        if K.admins.contains(email) {
                            user_type = "Admin"
                        }
                        
                        //add user to cloud firestore database
                        self.db.collection("users").document(userId).setData([
                            "userId": userId,
                            "username": username,
                            "email" : email,
                            "user_type": user_type
                        ]) { err in
                            if let err = err {
                                print("Error writing document: \(err)")
                            } else {
                                print("Document successfully written!")
                            }
                        }

                        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                            self.activityIndicator.stopAnimating()
                            if let e = error {
                                print(e.localizedDescription)
                            } else {
                                self.performSegue(withIdentifier: K.registerToGuidesSegue, sender: self)
                            }
                        }
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
