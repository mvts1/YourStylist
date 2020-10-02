//
//  GuideDetailController.swift
//  YourStylist
//
//  Created by Onur Mavitas on 2.09.2020.
//  Copyright © 2020 Onur Mavitas. All rights reserved.
//

import UIKit

class GuideDetailController: UIViewController {
    static let identifier = String(describing: GuideDetailController.self)
    private let guide: Guide

    @IBOutlet weak var guideCoverImageView: UIImageView!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publishDate: UILabel!
    @IBOutlet weak var faveButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var photoDetailButton: UIButton!
    @IBOutlet weak var imageView1: UIImageView!
    
    @IBAction func photoDetailButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: K.photoDetailSegue, sender: self)
    }
    
    
    init?(coder: NSCoder, guide: Guide) {
        self.guide = guide
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView() {

        guideCoverImageView.image = guide.coverImage
        titleLabel.text = guide.title
        content.text = guide.content
        imageView1.image = guide.image1
        publishDate.text = guide.formattedDate(using: dateFormatter)
        
    }
}
