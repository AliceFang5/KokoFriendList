//
//  FriendMainViewController.swift
//  KokoFriendList
//
//  Created by 方芸萱 on 2024/7/7.
//

import UIKit

class FriendMainViewController: UIViewController {
    
    
    private let viewModel = FriendMainViewModel()
    
    private lazy var accountInfoView = AccountInfoView()
    private lazy var emptyView = EmptyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchData()
    }
}
