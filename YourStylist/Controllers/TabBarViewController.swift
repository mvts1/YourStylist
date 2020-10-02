//
//  TabBarViewController.swift
//  YourStylist
//
//  Created by Onur Mavitas on 28.09.2020.
//  Copyright © 2020 Onur Mavitas. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController,  UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        // If your view controller is embedded in a UINavigationController you will need to check if it's a UINavigationController and check that the root view controller is your desired controller (or subclass the navigation controller)
        if viewController is AskViewController {

            let storyboard = UIStoryboard(name: "Ask", bundle: nil)
            if let controller = storyboard.instantiateViewController(withIdentifier: "AskVC") as? AskViewController {
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: true, completion: nil)
            }

            return false
        }

        // Tells the tab bar to select other view controller as normal
        return true
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
