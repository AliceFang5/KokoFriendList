//
//  FriendListSource.swift
//  KokoFriendList
//
//  Created by 方芸萱 on 2024/7/7.
//

import Foundation

enum FriendListSource {
    /// 好友列表1
    case list1
    /// 好友列表2
    case list2
    /// 好友列表含邀請列表
    case listWithInvite
    /// 無資料邀請/好友列表
    case listNoData
    
    var urlString: String {
        switch self {
        case .list1: "https://dimanyen.github.io/friend1.json"
        case .list2: "https://dimanyen.github.io/friend2.json"
        case .listWithInvite: "https://dimanyen.github.io/friend3.json"
        case .listNoData: "https://dimanyen.github.io/friend4.json"
        }
    }
}
