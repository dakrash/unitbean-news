//
//  ArticleColletcionViewCell.swift
//  unitbean-news
//
//  Created by darya on 21.04.2020.
//  Copyright © 2020 darya. All rights reserved.
//

import UIKit
import SwiftSVG

class ArticleCell : UITableViewCell {
    static let identifer = "articleCell"
    @IBOutlet weak var im: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var commentsicon: SVGView!
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
}
