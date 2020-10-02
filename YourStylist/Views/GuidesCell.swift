//
//  GuidesCell.swift
//  YourStylist
//
//  Created by Onur Mavitas on 31.08.2020.
//  Copyright © 2020 Onur Mavitas. All rights reserved.
//

import UIKit

class GuidesCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: GuidesCell.self)
    
    @IBOutlet weak var guideImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var snippetLabel: UILabel!
}
