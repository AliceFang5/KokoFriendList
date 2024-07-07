//
//  FriendMainViewModel.swift
//  KokoFriendList
//
//  Created by 方芸萱 on 2024/7/7.
//

import Foundation

class FriendMainViewModel {
    
    private let dataProvider = DataProvider.shared
    
    func fetchData() {
        dataProvider.fetchAccountData()
        dataProvider.fetchFriendListData()
    }
}
