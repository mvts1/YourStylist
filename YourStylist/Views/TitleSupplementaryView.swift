//
//  TitleSupplementaryView.swift
//  YourStylist
//
//  Created by Onur Mavitas on 16.09.2020.
//  Copyright © 2020 Onur Mavitas. All rights reserved.
//

import UIKit

final class TitleSupplementaryView: UICollectionReusableView {
    static let reuseIdentifier = String(describing: TitleSupplementaryView.self)
    
    let textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
    
    private func configure() {
        addSubview(textLabel)
        
        textLabel.font = UIFont(name: "Raleway-SemiBold", size: 18)
        textLabel.translatesAutoresizingMaskIntoConstraints = false //this is needed when setting up autolayout constraints from code
        
        let inset: CGFloat = 10
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset)
        ])
    }
}
