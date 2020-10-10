//
//  FeedbackViewController.swift
//  YourStylist
//
//  Created by Onur Mavitas on 19.08.2020.
//  Copyright © 2020 Onur Mavitas. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var currentTableView: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func switchTableViewAction(_ sender: UISegmentedControl) {
        currentTableView = sender.selectedSegmentIndex
        tableView.reloadData()
    }
}

//extension FeedbackViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        //how many posts the user has uploaded?
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//
//    }
//
//
//}



