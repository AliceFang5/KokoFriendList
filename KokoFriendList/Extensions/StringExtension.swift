//
//  StringExtension.swift
//  KokoFriendList
//
//  Created by 方芸萱 on 2024/7/15.
//

import UIKit

extension String {
    
    static let dateFormatter: DateFormatter = {
        let new = DateFormatter()
        new.timeZone = TimeZone(identifier: "Asia/Taipei") ?? TimeZone(secondsFromGMT: 8 * 60 * 60) ?? TimeZone.current
        new.dateFormat = "yyyyMMdd"
        return new
    }()

    func toDate(_ format: String) -> Date? {
        let dateformatter = String.dateFormatter
        dateformatter.dateFormat = format
        return dateformatter.date(from: self)
    }
}
