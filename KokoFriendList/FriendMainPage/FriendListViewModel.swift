//
//  FriendListViewModel.swift
//  KokoFriendList
//
//  Created by 方芸萱 on 2024/7/7.
//

import Foundation

class FriendListViewModel {
    
    private var friendList: [FriendInfo] = []
    
    func updateFriendList(list: [FriendInfo]) {
        friendList = list
    }
    
    func getFriendListCount() -> Int {
        return friendList.count
    }
    
    func getFriendInfo(index: Int) -> FriendInfo? {
        guard friendList.indices.contains(index) else { return nil }
        return friendList[index]
    }
}
