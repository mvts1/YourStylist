//
//  AskViewController.swift
//  YourStylist
//
//  Created by Onur Mavitas on 17.08.2020.
//  Copyright © 2020 Onur Mavitas. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import Firebase

class AskViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var questionTextField: UITextField!
    
    var imagePicker: ImagePicker!
    @IBOutlet weak var pickerButton: UIButton!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.textColor = UIColor.lightGray
        textView.delegate = self
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        pruneNegativeWidthConstraints()
//
        pickerButton.backgroundColor = .clear
        pickerButton.layer.cornerRadius = 5
        pickerButton.layer.borderWidth = 0.3
        pickerButton.layer.borderColor = UIColor.black.cgColor
        shareButton.isEnabled = false
        progressBar.isHidden = true
        showImagePicker(pickerButton)
        
    }
    

    @IBAction func shareButtonTapped(_ sender: UIBarButtonItem) {
        if let user = Auth.auth().currentUser { //checks if there's a current user
            
            guard let titleText = questionTextField.text else {
                let alert = UIAlertController(title: "A title is needed for your post", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Button", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
                }
            guard let explanation = textView.text else {
                let alert = UIAlertController(title: "You should provide more information", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Button", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            let currentDate = Date().description
            
            progressBar.isHidden = false
            
            let userId = user.uid
            let imageId: String = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "_")
            let postId: String = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "_")
            let imageName = "\(imageId).jpg"
            //create the path to this image on cloud, a folder for each user
            let pathToPicture = "images/\(user.uid)/\(postId)/\(imageName)"
            
            let storageRef = Storage.storage().reference(withPath: pathToPicture)
            guard let imageData = imageView.image?.jpegData(compressionQuality: 0.75) else { return }
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpg" //this ensures that the image is represented a a jpg
            //create the upload task
            let taskReference = storageRef.putData(imageData, metadata: metaData) { (downloadMetaData, error) in
                if let error = error {
                    print("Got an error! \(error.localizedDescription)")
                    return
                }
                print("Upload is complete and I got this back: \(String(describing: downloadMetaData))")
            }
            
            taskReference.observe(.progress) { [weak self] (snapshot) in //task snapshot object tells me about the current state of the upload
                guard let pctThere = snapshot.progress?.fractionCompleted else { return }
                print("You are \(pctThere) complete")
                self?.progressBar.progress = Float(pctThere)
            }
            
            //update posts collection in the database. Comments and likes will be saved there.
            self.db.collection("users").document(userId).setData([
            "posts": [postId: [
            "date": currentDate,
            "question_title": titleText,
            "explanation": explanation
            ]]
            ], merge: true) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { //to delay the dismiss method call
                self.dismiss(animated: true, completion: nil)
            }
            
        }
    }
    
    @IBAction func showImagePicker(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func pruneNegativeWidthConstraints() {
            for subView in self.view.subviews {
                for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
                    subView.removeConstraint(constraint)
                }
            }
        }
}


extension AskViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.imageView.image = image
        shareButton.isEnabled = true
    }
}

//MARK: - TextView Delegate Methods

extension AskViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = nil
        if textView.textColor == UIColor.lightGray {
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
