//
//  LandingViewController.swift
//  KokoFriendList
//
//  Created by 方芸萱 on 2024/7/15.
//

import UIKit

class LandingViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "歡迎來到KOKO好友列表\n請選擇想Demo的畫面："
        label.textColor = .greyishBrown
        label.font = UIFont.pingFangTC(size: 21, type: .medium)
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    private lazy var demoButtonList = [DemoButton(demoType: .listNoData),
                                       DemoButton(demoType: .listWithoutInvite),
                                       DemoButton(demoType: .listWithInvite)]
    private lazy var currentDemoButton: DemoButton = demoButtonList[0]
    private lazy var demoButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: demoButtonList)
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var confirmButton: GradientButton = {
        let button = GradientButton(_gradientLayer: Constant.buttonGradientLayer)
        button.setTitle("確定", for: .normal)
        button.setTitleColor(.whiteThree, for: .normal)
        button.titleLabel?.font = UIFont.pingFangTC(size: 16, type: .medium)
        button.addTarget(self, action: #selector(onConfirmButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.layer.shadowColor = UIColor.appleGreen40.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        currentDemoButton.isSelect(true)
        
        demoButtonList.forEach { button in
            button.addTarget(self, action: #selector(onButtonTapped(sender:)), for: .touchUpInside)
        }
    }
}

private extension LandingViewController {
    
    func setupUI() {
        view.backgroundColor = .whiteThree
        view.addSubview(titleLabel)
        view.addSubview(demoButtonStackView)
        view.addSubview(confirmButton)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().inset(100)
            make.top.equalToSuperview().inset(200)
        }
        
        demoButtonStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(100)
            make.top.equalTo(titleLabel.snp.bottom).offset(60)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(100)
            make.height.equalTo(60)
            make.top.equalTo(demoButtonStackView.snp.bottom).offset(60)
        }
    }
    
    func pushToMainPage() {
        let mainVC = MainTabBarController()
        navigationController?.pushViewController(mainVC, animated: false)
    }
    
    @objc func onConfirmButtonTapped() {
        DataProvider.shared.updateDemoType(currentDemoButton.demoType)
        pushToMainPage()
    }
    
    @objc func onButtonTapped(sender: DemoButton) {
        currentDemoButton.isSelect(false)
        sender.isSelect(true)
        currentDemoButton = sender
    }
}
