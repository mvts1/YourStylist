//
//  CameraViewController.swift
//  YourStylist
//
//  Created by Onur Mavitas on 28.09.2020.
//  Copyright © 2020 Onur Mavitas. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController {
    
    static let identifier = String(describing: CameraViewController.self)
    var imagePicker: ImagePicker!
    
    @IBOutlet weak var imageView: UIImageView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    @IBAction func showImagePicker(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }

}

extension CameraViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.imageView.image = image
    }
}
