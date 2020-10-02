//
//  CameraViewController.swift
//  YourStylist
//
//  Created by Onur Mavitas on 28.09.2020.
//  Copyright © 2020 Onur Mavitas. All rights reserved.
//

import UIKit
import CameraManager

class CameraViewController: UIViewController {

    @IBOutlet weak var cameraView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cameraManager = CameraManager()
        cameraManager.addPreviewLayerToView(self.cameraView)
        // Do any additional setup after loading the view.
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
