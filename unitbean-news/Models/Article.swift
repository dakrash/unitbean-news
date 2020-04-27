//
//  Article.swift
//  unitbean-news
//
//  Created by darya on 21.04.2020.
//  Copyright © 2020 darya. All rights reserved.
//

import UIKit

class Article {
    let tag : String
    let date : Date
    let imageUrl : URL
    let commentsCount : Int
    let title : String
    let url : URL
    var image : UIImage?
    init(authorName : String, date : Date, imageUrl : URL, commentsCount : Int, title : String, url : URL){
        self.tag = authorName
        self.date = date
        self.imageUrl = imageUrl
        self.commentsCount = commentsCount
        self.title = title
        self.url = url
    }
}
