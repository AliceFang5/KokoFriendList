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
    
    private lazy var friendInfoDic: [String: FriendInfo] = [:]
    private lazy var friendFidList: [String] = []
    private lazy var demoType: DemoType = .listNoData
    
    func fetchAccountData() {
        let urlString = "https://dimanyen.github.io/man.json"
        if let url = URL(string: urlString){
            let task = URLSession.shared.dataTask(with: url) { (data, request, err) in
                if let data = data, let result = try? JSONDecoder().decode(AccountResult.self, from: data){
                    if let accountInfo = result.response.first {
                        self.delegate?.didReceiveAccountInfo(accountInfo)
                    }
                }
            }
            task.resume()
        }
    }
    
    func fetchFriendListData() {
        
        let group = DispatchGroup()
        let friendListSourceList = demoType.getFriendListSource()
        friendListSourceList.forEach { friendListSource in
            group.enter()
            let urlString = friendListSource.urlString
            if let url = URL(string: urlString){
                let task = URLSession.shared.dataTask(with: url) { (data, request, err) in
                    if let data = data, let result = try? JSONDecoder().decode(FriendListResult.self, from: data){
                        self.updateFriendList(result.response)
                        group.leave()
                    }
                }
                task.resume()
            }
        }
        
        group.notify(queue: .main) {
            let friendList = self.friendFidList.compactMap { fid in
                return self.friendInfoDic[fid]
            }
            self.delegate?.didReceiveFriendList(friendList)
        }
    }
    
    func updateFriendList(_ newList: [FriendInfo]) {
        newList.forEach { newItem in
            
            guard let oldItem = friendInfoDic[newItem.fid] else {
                // fid無資料，加入新資料
                friendInfoDic[newItem.fid] = newItem
                friendFidList.append(newItem.fid)
                return
            }
            
            // fid有資料，比較updateDate，更新資料
            guard let oldDate = oldItem.updateDate.toDate("yyyyMMdd") else { return }
            
            // 新資料的日期格式為yyyyMMdd，可直接比較
            if let newDate = newItem.updateDate.toDate("yyyyMMdd") {
                
                let newInfo = oldDate > newDate ? oldItem : newItem
                friendInfoDic[newItem.fid] = newInfo
                return
            }
            
            // 新資料的日期格式為yyyy/MM/dd，統一格式為yyyyMMdd
            if let newDate = newItem.updateDate.toDate("yyyy/MM/dd") {
                
                var newInfo = oldItem
                if oldDate < newDate {
                    newInfo = newItem
                    let dateFormatter = String.dateFormatter
                    dateFormatter.dateFormat = "yyyyMMdd"
                    newInfo.updateDate = dateFormatter.string(from: newDate)
                }
                friendInfoDic[newItem.fid] = newInfo
                return
            }
            
            // 新資料的日期格式錯誤，不動作
            return
        }
    }
    
    func updateDemoType(_ type: DemoType) {
        demoType = type
    }
}
