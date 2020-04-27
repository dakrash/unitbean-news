//
//  String + extension.swift
//  unitbean-news
//
//  Created by darya on 25.04.2020.
//  Copyright © 2020 darya. All rights reserved.
//

import UIKit
extension String {
    func getDate() -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self)
    }
    
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
