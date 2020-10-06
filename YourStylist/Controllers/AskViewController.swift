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

class AskViewController: UIViewController {
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var progressView: UIView!
    
    var imagePicker: ImagePicker!
    @IBOutlet weak var pickerButton: UIButton!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        textView.textColor = UIColor.lightGray
//        textView.delegate = self
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        pruneNegativeWidthConstraints()
//
        pickerButton.backgroundColor = .clear
        pickerButton.layer.cornerRadius = 5
        pickerButton.layer.borderWidth = 0.3
        pickerButton.layer.borderColor = UIColor.black.cgColor
        shareButton.isEnabled = false
        showImagePicker(pickerButton)
        
    }
    

    @IBAction func shareButtonTapped(_ sender: UIBarButtonItem) {
        if let user = Auth.auth().currentUser { //checks if there's a current user
            let imageId: String = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "_")
            let imageName = "\(imageId).jpg"
            //create the path to this image on cloud, a folder for each user
            let pathToPicture = "images/\(user.uid)/\(imageName)"
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
            
            taskReference.observe(.progress) { (snapshot) in //task snapshot object tells me about the current state of the upload
                guard let pctThere = snapshot.progress?.fractionCompleted else { return }
                print("You are \(pctThere) complete")
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
