//
//  Post.swift
//  YourStylist
//
//  Created by Onur Mavitas on 10.10.2020.
//  Copyright © 2020 Onur Mavitas. All rights reserved.
//

import UIKit

class Post {
    let identifier = UUID().uuidString
    var images: [UIImage]
    var comments: [String]
    var userId: String
    var date: String
    var title: String
    var explanation: String
    
    init(explanation: String, title: String, images: [UIImage], comments: [String], userId: String, likes: Int, date: String) {
        self.images = images
        self.comments = comments
        self.userId = userId
        self.date = date
        self.title = title
        self.explanation = explanation
    }
}
