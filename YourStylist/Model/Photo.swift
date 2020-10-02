//
//  Photo.swift
//  YourStylist
//
//  Created by Onur Mavitas on 23.09.2020.
//  Copyright © 2020 Onur Mavitas. All rights reserved.
//

import UIKit

class Photo {
    let identifier = UUID().uuidString
    let guideTitle: String
    let imageName: String
    let image: UIImage
    
    init(imageName: String, guideTitle: String) {
        self.imageName = imageName
        self.guideTitle = guideTitle
        image = UIImage(named: imageName)!
    }
}

extension Photo: Hashable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.guideTitle == rhs.guideTitle
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
