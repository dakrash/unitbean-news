//
//  ArticleDetails.swift
//  unitbean-news
//
//  Created by darya on 26.04.2020.
//  Copyright © 2020 darya. All rights reserved.
//

import UIKit

class ArticleDetails {
    let imageGalleruURL : [URL]
    let htmlBody : String
    init(imageGalleruURL : [URL], htmlBody : String){
        self.imageGalleruURL = imageGalleruURL
        self.htmlBody = htmlBody
    }
}
