//
//  DataSource.swift
//  YourStylist
//
//  Created by Onur Mavitas on 10.09.2020.
//  Copyright © 2020 Onur Mavitas. All rights reserved.
//

import UIKit

class DataSource {
    
    static let shared = DataSource.init()
    
    var guideCol: [GuideCollection]
    private let numOfSections = 5
    private let numOfGuides = 5
    var photos: [Photo]
    
    init() {
        var guideCols: [GuideCollection] = []
        for y in (0...numOfSections-1) {
            var guides: [Guide] = []
            for x in (0...numOfGuides-1) {
                let guide = Guide(y, x, guide_title, snippet, content, publishDate, "2", "vet1", "vet2")
                guides.append(guide)
            }
            let guideCol = GuideCollection.init(guides, section_titles[y])
            guideCols.append(guideCol)
        }
        self.guideCol = guideCols
        
        self.photos = [
            Photo(imageName: "2", guideTitle: guide_title),
            Photo(imageName: "3", guideTitle: guide_title),
            Photo(imageName: "4", guideTitle: guide_title)
        ]
    }
    
    
    let content = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu pellentesque magna. Curabitur dapibus augue vel dui aliquam varius. Phasellus a enim nec tortor pretium placerat. Etiam eu lectus urna. Vestibulum mattis eleifend tempus. Nulla id nisl nisl. Ut at velit ultricies, mollis orci quis, viverra risus. Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed pellentesque elit sodales turpis finibus, at sodales nibh fermentum. Donec lacinia nulla feugiat tincidunt pellentesque.
            
    Praesent dapibus et ligula nec hendrerit. Curabitur volutpat lorem ante, id venenatis enim gravida quis. Aliquam feugiat placerat mi, in interdum ante tincidunt at. Duis fringilla augue a est faucibus, sed maximus augue pellentesque. Cras metus purus, malesuada at feugiat sit amet, bibendum ac elit. Proin placerat condimentum lectus sit amet feugiat. Etiam eu porttitor leo. Donec massa arcu, pretium eget luctus non, maximus eu erat. Suspendisse congue enim enim, quis hendrerit eros volutpat quis. Morbi commodo faucibus metus, et sagittis sem malesuada id. Integer at sem id tortor dignissim fringilla sed venenatis dui. Nullam malesuada est et pulvinar dignissim. Nulla massa diam, porta eget euismod eget, dignissim non nisi. Proin lorem ex, mattis quis fringilla sit amet, malesuada eget leo.
    """
    
    let snippet = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu pellentesque magna."
    let guide_title = "Lorem ipsum dolor sit"
    let section_titles = ["2020 Spring-Summer Trends", "2020 Fall-Winter Trends", "The things that you should know", "Rising Designers", "Self-Care"]
    let publishDate = Date()

}
