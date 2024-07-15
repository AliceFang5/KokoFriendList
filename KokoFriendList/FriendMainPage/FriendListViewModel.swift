//
//  FriendListViewModel.swift
//  KokoFriendList
//
//  Created by 方芸萱 on 2024/7/7.
//

import Foundation

class FriendListViewModel {
    
    private var originalFriendList: [FriendInfo] = []
    private var friendList: [FriendInfo] = []
    private var searchText: String = ""
    
    func updateFriendList(list: [FriendInfo]) {
        originalFriendList = list
        updateFriendListWithSearchText()
    }
    
    func updateSearchText(_ text: String) {
        searchText = text
        updateFriendListWithSearchText()
    }
    
    func getFriendListCount() -> Int {
        return friendList.count
    }
    
    func getFriendInfo(index: Int) -> FriendInfo? {
        guard friendList.indices.contains(index) else { return nil }
        return friendList[index]
    }
}

private extension FriendListViewModel {
    
    func updateFriendListWithSearchText() {
        guard !searchText.isEmpty else {
            friendList = originalFriendList
            return
        }
        
        let filterList = originalFriendList.filter { info in
            return info.name.contains(searchText)
        }
        friendList = filterList
    }
}
