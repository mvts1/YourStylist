//
//  BadgeSupplementaryView.swift
//  YourStylist
//
//  Created by Onur Mavitas on 17.09.2020.
//  Copyright © 2020 Onur Mavitas. All rights reserved.
//

import UIKit

final class BadgeSupplementaryView: UICollectionReusableView {
    //suplementary views are set up much like cells, so we start with a reuse identifier
    static let reuseIdentifier = String(describing: BadgeSupplementaryView.self)
    
    //since this is a view defined in code, we need to add an initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configure() {
        backgroundColor = UIColor(named: "rw-green")
        let radius = bounds.width / 2.0
        layer.cornerRadius = radius
    }
}
