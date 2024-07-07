//
//  DataProvider.swift
//  KokoFriendList
//
//  Created by 方芸萱 on 2024/7/7.
//

import Foundation

protocol DataProviderDelegate: AnyObject {
    func didReceiveAccountInfo(_ accountInfo: AccountInfo)
    func didReceiveFriendList(_ list: [FriendInfo])
}

class DataProvider {
    
    static var shared = DataProvider()
    private init(){}
    
    weak var delegate: DataProviderDelegate?
    
    lazy var accountInfo: AccountInfo? = nil
    lazy var friendList: [FriendInfo] = []
    private lazy var friendListSource: FriendListSource = .list1
    
    func fetchAccountData() {
        let urlString = "https://dimanyen.github.io/man.json"
        if let url = URL(string: urlString){
            let task = URLSession.shared.dataTask(with: url) { (data, request, err) in
                if let data = data, let result = try? JSONDecoder().decode(AccountResult.self, from: data){
                    if let accountInfo = result.response.first {
                        self.accountInfo = accountInfo
                        self.delegate?.didReceiveAccountInfo(accountInfo)
                    }
                }
            }
            task.resume()
        }
    }
    
    func fetchFriendListData() {
        let urlString = friendListSource.urlString
        if let url = URL(string: urlString){
            let task = URLSession.shared.dataTask(with: url) { (data, request, err) in
                if let data = data, let result = try? JSONDecoder().decode(FriendListResult.self, from: data){
                    self.friendList = result.response
                    self.delegate?.didReceiveFriendList(self.friendList)
                }
            }
            task.resume()
        }
    }
    
    func updateFriendListSource(_ newSource: FriendListSource) {
        friendListSource = newSource
    }
}
