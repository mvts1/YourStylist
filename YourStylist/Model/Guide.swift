//
//  Guide.swift
//  YourStylist
//
//  Created by Onur Mavitas on 14.09.2020.
//  Copyright © 2020 Onur Mavitas. All rights reserved.
//
import UIKit

class Guide {
    //Guide will be the item type in the collection view
    let identifier = UUID().uuidString
    var title: String
    var content: String
    var snippet: String
    var section_num: Int
    var guide_num: Int
    var publishDate: Date
    var thumbnail: String
    var coverImage: UIImage
    var image1Name: String
    var image1: UIImage
    var isFave: Bool = false
    
    init(_ section_num: Int,_ guide_num: Int,_ title: String,_ snippet: String,_ content: String, _ publishDate: Date,_ thumbnail: String,_ image1Name: String,_ image2Name: String) {
        self.section_num = section_num
        self.guide_num = guide_num
        self.title = title
        self.snippet = snippet
        self.content = content
        self.publishDate = publishDate
        self.thumbnail = thumbnail
        self.coverImage = UIImage(named: thumbnail)!
        self.image1Name = image1Name
        self.image1 = UIImage(named: image1Name)!
    }
    
    func formattedDate(using formatter: DateFormatter) -> String? {
      return formatter.string(from: publishDate)
    }
}

extension Guide: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

extension Guide: Equatable {
    static func == (lhs: Guide, rhs: Guide) -> Bool {
        return lhs.title == rhs.title &&
            lhs.publishDate == rhs.publishDate
    }
}

