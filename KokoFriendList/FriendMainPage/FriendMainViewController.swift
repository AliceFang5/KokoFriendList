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
    private lazy var currentIndex: Int = 0
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
        inviteListView.isHidden = true
        setPageVC(index: currentIndex)
        chatListButton.updateNotifyCount(100) //demo
    }
    
    func setPageVC(index: Int) {
        guard menuButtonList.indices.contains(index) else { return }
        menuButtonList[currentIndex].isSelect(false)
        menuButtonList[index].isSelect(true)
        
        var direction: UIPageViewController.NavigationDirection = .forward
        if index < currentIndex {
            direction = .reverse
        }
        let vc = viewControllers[index]
        pageVC.setViewControllers([vc],
                                  direction: direction,
                                  animated: true,
                                  completion: nil)
        currentIndex = index
    }
    
    @objc func onMenuButtonTapped(sender: MenuButton) {
        guard let index = menuButtonList.firstIndex(of: sender) else { return }
        setPageVC(index: index)
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
            
            // status == 0, 表示為邀請送出，需要更新好友邀請欄位，不需要顯示在好友列表
            let inviteList = list.filter { $0.status == 0 }
            self.inviteListView.updateInfoList(infoList: inviteList)
            self.inviteListView.isHidden = inviteList.isEmpty
            
            let friendList = list.filter { $0.status != 0 }
            self.friendListVC.updateFriendList(list: friendList)
            
            // status == 2, 表示為邀請中，需要更新好友頁籤右上角count
            let isDuringInviteListCount = list.filter { $0.status == 2 }.count
            self.friendListButton.updateNotifyCount(isDuringInviteListCount)
        }
    }
}

extension FriendMainViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController) else { return nil }
        let preIndex = index - 1
        guard viewControllers.indices.contains(preIndex) else {
            return nil
        }
        return viewControllers[preIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        guard viewControllers.indices.contains(nextIndex) else {
            return nil
        }
        return viewControllers[nextIndex]
    }
}
