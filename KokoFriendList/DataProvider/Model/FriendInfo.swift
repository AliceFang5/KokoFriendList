//
//  FriendInfo.swift
//  KokoFriendList
//
//  Created by 方芸萱 on 2024/7/7.
//

import Foundation

struct FriendListResult: Decodable {
    let response: [FriendInfo]
}

struct FriendInfo: Decodable {
    var name: String
    var status: Int
    var isTop: String
    let fid: String
    var updateDate: String
}
