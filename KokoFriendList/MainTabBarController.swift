//
//  MainTabBarController.swift
//  KokoFriendList
//
//  Created by 方芸萱 on 2024/7/7.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
}

private extension MainTabBarController {
    
    func setupTabBar() {
        tabBar.backgroundColor = .background
        let firstVC = getFriendMainVC()
        let secondVC = getSeconeMainVC()
        self.viewControllers = [firstVC, secondVC]
    }
    
    func getFriendMainVC() -> UIViewController {
        
        let vc = FriendMainViewController()
        vc.tabBarItem.title = NSLocalizedString("朋友", comment: "")
        vc.tabBarItem.image = .init(systemName: "face.smiling")
        vc.tabBarItem.selectedImage = .init(systemName: "face.smiling.fill")
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }
    
    func getSeconeMainVC() -> UIViewController {
        
        let vc = EditMainViewController()
        vc.tabBarItem.title = NSLocalizedString("編輯", comment: "")
        vc.tabBarItem.image = .init(systemName: "pencil.circle")
        vc.tabBarItem.selectedImage = .init(systemName: "pencil.circle.fill")
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }
}
