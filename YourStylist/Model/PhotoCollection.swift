//
//  PhotoCollection.swift
//  YourStylist
//
//  Created by Onur Mavitas on 23.09.2020.
//  Copyright © 2020 Onur Mavitas. All rights reserved.
//

import UIKit

class PhotoCollection {
    var photos: [Photo]
    let identifier = UUID().uuidString
    
    init(_ photos: [Photo]) {
        self.photos = photos
    }
}

extension PhotoCollection: Hashable {
    static func == (lhs: PhotoCollection, rhs: PhotoCollection) -> Bool {
        return lhs.photos == rhs.photos
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
