//
//  AskViewController.swift
//  YourStylist
//
//  Created by Onur Mavitas on 17.08.2020.
//  Copyright © 2020 Onur Mavitas. All rights reserved.
//

import UIKit



class AskViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var photoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.textColor = UIColor.lightGray
        textView.delegate = self
        
    }

    @IBAction func photoButtonPressed(_ sender: UIButton) {
        //Create the action buttons for the alert
        let libraryAction = UIAlertAction(title: "Choose from library", style: .default) { (action) in
            //Respond to user selection of action
        }
        let cameraAction = UIAlertAction(title: "Use the camera", style: .default) { (action) in
            //Respond to user selection of action
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        //Create and configure the alert controller
        let alert = UIAlertController(title: "Add a photo", message: "", preferredStyle: .actionSheet)
        alert.addAction(libraryAction)
        alert.addAction(cameraAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true) {
            //Alert was presented
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Describe your vision for the outfit or ask for advice"
            textView.textColor = UIColor.lightGray
        }
    }
}
