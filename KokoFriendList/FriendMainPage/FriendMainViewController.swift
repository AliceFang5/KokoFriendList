//
//  FriendMainViewController.swift
//  KokoFriendList
//
//  Created by 方芸萱 on 2024/7/7.
//

import UIKit

class FriendMainViewController: UIViewController {
    
    private let viewModel = FriendMainViewModel()
    
    private lazy var atmBarButton: UIBarButtonItem = {
        let imageView = UIImageView(image: UIImage(named: "icNavPinkWithdraw"))
        let barBtn = UIBarButtonItem(customView: imageView)
        return barBtn
    }()
    
    private lazy var transferMoneyBarButton: UIBarButtonItem = {
        let imageView = UIImageView(image: UIImage(named: "icNavPinkTransfer"))
        let barBtn = UIBarButtonItem(customView: imageView)
        return barBtn
    }()
    
    private lazy var scanBarButton: UIBarButtonItem = {
        let imageView = UIImageView(image: UIImage(named: "icNavPinkScan"))
        let barBtn = UIBarButtonItem(customView: imageView)
        return barBtn
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [accountInfoView])
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var accountInfoView = AccountInfoView()
    //    InviteListView
    
    private lazy var pageVC: UIPageViewController = {
        let pageVC = UIPageViewController(transitionStyle: .scroll,
                                          navigationOrientation: .horizontal,
                                          options: nil)
        return pageVC
    }()
    
    private lazy var viewControllers: [UIViewController] = [friendListVC,
                                                            chatListVC]
    private lazy var friendListVC = FriendListViewController()
    private lazy var chatListVC = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchData()
        setupNavBar()
        setupUI()
        
        pageVC.setViewControllers([friendListVC],
                                  direction: .forward,
                                  animated: false,
                                  completion: nil)
    }
}

private extension FriendMainViewController {
    
    func setupNavBar() {
        tabBarController?.navigationController?.navigationBar.backgroundColor = .background
        tabBarController?.navigationItem.leftBarButtonItems = [atmBarButton,
                                                               transferMoneyBarButton]
        tabBarController?.navigationItem.rightBarButtonItem = scanBarButton
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        addChild(pageVC)
        view.addSubview(pageVC.view)
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        accountInfoView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(54)
        }
        
        pageVC.view.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension FriendMainViewController: FriendMainViewModelDelegate {
    
    func didReceiveAccountInfo(_ accountInfo: AccountInfo) {
        DispatchQueue.main.async {
            self.accountInfoView.updateAccountInfo(accountInfo)
        }
    }
    
    func didReceiveFriendList(_ list: [FriendInfo]) {
//        DispatchQueue.main.async {
//
//        }
    }
}
