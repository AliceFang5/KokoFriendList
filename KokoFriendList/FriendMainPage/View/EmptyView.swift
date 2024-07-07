//
//  EmptyView.swift
//  KokoFriendList
//
//  Created by 方芸萱 on 2024/7/7.
//

import UIKit
import SnapKit

class EmptyView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "imgFriendsEmpty")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "就從加好友開始吧：）"
        label.textColor = .greyishBrown
        label.font = UIFont.pingFangTC(size: 21, type: .medium)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "與好友們一起用 KOKO 聊起來！\n還能互相收付款、發紅包喔：）"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .lightGrey
        label.font = UIFont.pingFangTC(size: 14)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [helpLabel, setIDLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private let helpLabel: UILabel = {
        let label = UILabel()
        label.text = "幫助好友更快找到你？"
        label.textAlignment = .right
        label.textColor = .lightGrey
        label.font = UIFont.pingFangTC(size: 13)
        return label
    }()
    
    private let setIDLabel: UILabel = {
        let label = UILabel()
        label.text = "設定 KOKO ID"
        label.textColor = .hotPink
        label.font = UIFont.pingFangTC(size: 13)
        return label
    }()
    
    private let addFriendButton: UIButton = {
        let button = UIButton()
        button.setTitle("加好友", for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 20
        // gradientButton
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension EmptyView {
    
    func setupUI() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(addFriendButton)
        addSubview(stackView)
        
        imageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.653)
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(41)
            make.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        addFriendButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(25)
            make.width.equalTo(192)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
    }
}
