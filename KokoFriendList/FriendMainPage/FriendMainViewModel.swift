//
//  FriendMainViewModel.swift
//  KokoFriendList
//
//  Created by 方芸萱 on 2024/7/7.
//

import Foundation

protocol FriendMainViewModelDelegate: AnyObject {
    func didReceiveAccountInfo(_ accountInfo: AccountInfo)
    func didReceiveFriendList(_ list: [FriendInfo])
}

class FriendMainViewModel {
    
    weak var delegate: FriendMainViewModelDelegate?
    
    private let dataProvider = DataProvider.shared
    
    lazy var accountInfo: AccountInfo? = nil
    lazy var friendList: [FriendInfo] = []
    
    func fetchData() {
        dataProvider.delegate = self
        dataProvider.fetchAccountData()
        dataProvider.fetchFriendListData()
    }
}

extension FriendMainViewModel: DataProviderDelegate {
    
    func didReceiveAccountInfo(_ accountInfo: AccountInfo) {
        self.accountInfo = accountInfo
        delegate?.didReceiveAccountInfo(accountInfo)
    }
    
    func didReceiveFriendList(_ list: [FriendInfo]) {
        self.friendList = list
        delegate?.didReceiveFriendList(list)
    }
}
