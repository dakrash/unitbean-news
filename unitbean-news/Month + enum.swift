//
//  Month + enum.swift
//  unitbean-news
//
//  Created by darya on 23.04.2020.
//  Copyright © 2020 darya. All rights reserved.
//

import UIKit

enum Month : Int {
    case january
    case february
    case march
    case april
    case may
    case june
    case july
    case august
    case september
    case october
    case november
    case december
    var text : String {
        switch self {
        case .january:
            return "января"
        case .february:
            return "февраля"
        case .march:
            return "марта"
        case .april:
            return "апреля"
        case .may:
            return "мая"
        case .june:
            return "июня"
        case .july:
            return "июля"
        case .august:
            return "августа"
        case .september:
            return "сентября"
        case .october:
            return "октября"
        case .november:
            return "ноября"
        case .december:
            return "декабря"
        }
    }
}
