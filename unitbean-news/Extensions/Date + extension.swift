//
//  Date + extension.swift
//  unitbean-news
//
//  Created by darya on 23.04.2020.
//  Copyright © 2020 darya. All rights reserved.
//

import UIKit

extension Date {
    func getString() -> String{
        let calendar = Calendar.current
        guard let monthStr = Month(rawValue: calendar.component(.month, from: self) - 1)?.text else {return ""}
        let minute = calendar.component(.minute, from: self)
        let minuteStr : String = (minute / 10 > 0) ? "\(minute)" : "0\(minute)"
        return "\(calendar.component(.day, from: self)) \(monthStr) в \(calendar.component(.hour, from: self)):\(minuteStr)"
    }
}
