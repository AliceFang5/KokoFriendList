//
//  AccountInfo.swift
//  KokoFriendList
//
//  Created by 方芸萱 on 2024/7/7.
//

import Foundation

struct AccountResult: Decodable {
    let response: [AccountInfo]
}

struct AccountInfo: Decodable {
    let name: String
    let kokoid: String
}
