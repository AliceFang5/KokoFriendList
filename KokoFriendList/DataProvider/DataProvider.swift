//
//  DataProvider.swift
//  KokoFriendList
//
//  Created by 方芸萱 on 2024/7/7.
//

import Foundation
import Combine

class DataProvider {
    
    static var shared = DataProvider()
    
    private init(){}
    
    private lazy var accountInfo: AccountInfo? = nil
    private lazy var friendList: [FriendInfo] = []
    private lazy var friendListSource: FriendListSource = .list1
    
    func fetchAccountData() {
        let urlString = "https://dimanyen.github.io/man.json"
        if let url = URL(string: urlString){
            let task = URLSession.shared.dataTask(with: url) { (data, request, err) in
                if let data = data, let result = try? JSONDecoder().decode(AccountResult.self, from: data){
                    if let accountInfo = result.response.first {
                        self.accountInfo = accountInfo
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
                }
            }
            task.resume()
        }
    }
    
    func updateFriendListSource(_ newSource: FriendListSource) {
        friendListSource = newSource
    }
}
