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
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints {
            $0.width.equalTo(50)
        }
        let barBtn = UIBarButtonItem(customView: imageView)
        return barBtn
    }()
    
    private lazy var scanBarButton: UIBarButtonItem = {
        let imageView = UIImageView(image: UIImage(named: "icNavPinkScan"))
        let barBtn = UIBarButtonItem(customView: imageView)
        return barBtn
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [accountInfoView,
                                                       inviteListView])
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var accountInfoView = AccountInfoView()
    private lazy var inviteListView = InviteListView()
    
    private lazy var menuButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
        return stackView
    }()
    private lazy var menuButtonList = [friendListButton, chatListButton]
    private let friendListButton = MenuButton(title: "好友")
    private let chatListButton = MenuButton(title: "聊天")
    private lazy var currentMenuButton: MenuButton? = nil
    private lazy var grayLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        return view
    }()
    
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
        
        setupMenuButtonView()
        setDefaultPage()
    }
}

private extension FriendMainViewController {
    
    func setupNavBar() {
        tabBarController?.navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.backgroundColor = .background
        navigationItem.leftBarButtonItems = [atmBarButton, transferMoneyBarButton]
        navigationItem.rightBarButtonItem = scanBarButton
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(topStackView)
        view.addSubview(menuButtonStackView)
        view.addSubview(grayLineView)
        addChild(pageVC)
        view.addSubview(pageVC.view)
        
        topStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        accountInfoView.snp.makeConstraints { make in
            make.height.equalTo(90)
        }
        
        menuButtonStackView.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom)
            make.leading.equalToSuperview().offset(32)
            make.height.equalTo(45)
        }
        
        grayLineView.snp.makeConstraints { make in
            make.top.equalTo(menuButtonStackView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        pageVC.view.snp.makeConstraints { make in
            make.top.equalTo(grayLineView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func setupMenuButtonView() {
        menuButtonList.forEach { menuButton in
            menuButtonStackView.addArrangedSubview(menuButton)
            menuButton.addTarget(self, action: #selector(onMenuButtonTapped(sender:)), for: .touchUpInside)
        }
    }

    func setDefaultPage() {
        friendListButton.isSelect(true)
        currentMenuButton = friendListButton
        friendListButton.updateNotifyCount(2)
        chatListButton.updateNotifyCount(100)
        
        pageVC.setViewControllers([friendListVC],
                                  direction: .forward,
                                  animated: false,
                                  completion: nil)
    }
    
    @objc func onMenuButtonTapped(sender: MenuButton) {
        guard let index = menuButtonList.firstIndex(of: sender) else { return }
        
        currentMenuButton?.isSelect(false)
        menuButtonList[index].isSelect(true)
        currentMenuButton = menuButtonList[index]
    }
}

extension FriendMainViewController: FriendMainViewModelDelegate {
    
    func didReceiveAccountInfo(_ accountInfo: AccountInfo) {
        DispatchQueue.main.async {
            self.accountInfoView.updateAccountInfo(accountInfo)
        }
    }
    
    func didReceiveFriendList(_ list: [FriendInfo]) {
        DispatchQueue.main.async {
            self.friendListVC.updateFriendList(list: list)
            let inviteList = list.filter { $0.status == 2 }
            self.inviteListView.updateInfoList(infoList: inviteList)
            self.inviteListView.isHidden = inviteList.isEmpty
        }
    }
}
