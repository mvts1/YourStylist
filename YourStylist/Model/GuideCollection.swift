//
//  GuideCollection.swift
//  YourStylist
//
//  Created by Onur Mavitas on 14.09.2020.
//  Copyright © 2020 Onur Mavitas. All rights reserved.
//

import Foundation

class GuideCollection: Hashable {
    //GuideCollection will be used as a section in the collection view
    var guides: [Guide]
    var title: String
    
    init(_ guides: [Guide],_ title: String) {
        self.guides = guides
        self.title = title
    }
    
    let identifier = UUID().uuidString
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(identifier)
    }
    
    static func == (lhs: GuideCollection, rhs: GuideCollection) -> Bool {
      return lhs.title == rhs.title
    }
}
