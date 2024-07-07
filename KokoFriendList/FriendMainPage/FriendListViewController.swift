//
//  FriendListViewController.swift
//  KokoFriendList
//
//  Created by 方芸萱 on 2024/7/7.
//

import UIKit
import SnapKit

class FriendListViewController: UIViewController {
    
    private lazy var emptyView = EmptyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

private extension FriendListViewController {
    
    func setupUI() {
        view.addSubview(emptyView)
        
        emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
