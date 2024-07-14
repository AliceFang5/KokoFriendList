//
//  InviteInfoView.swift
//  KokoFriendList
//
//  Created by 方芸萱 on 2024/7/8.
//

import UIKit
import SnapKit

class InviteInfoView: UIView {
    
    private let baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteThree
        view.layer.shadowColor = UIColor.black10.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 16
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "imgFriendsList")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .greyishBrown
        label.font = UIFont.pingFangTC(size: 16)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "邀請你成為好友：）"
        label.textColor = .lightGrey
        label.font = UIFont.pingFangTC(size: 13)
        return label
    }()
    
    private let agreeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btnFriendsAgree"), for: .normal)
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btnFriendsDelet"), for: .normal)
        return button
    }()
    
    init(info: FriendInfo) {
        super.init(frame: .zero)
        setupUI()
        nameLabel.text = info.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension InviteInfoView {
    
    func setupUI() {
        addSubview(baseView)
        baseView.addSubview(imageView)
        baseView.addSubview(nameLabel)
        baseView.addSubview(descriptionLabel)
        baseView.addSubview(agreeButton)
        baseView.addSubview(deleteButton)
        
        baseView.layer.cornerRadius = 6
        baseView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.bottom.equalToSuperview()
            make.height.equalTo(70)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.leading.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(15)
            make.bottom.equalTo(imageView.snp.centerY)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.leading)
            make.top.equalTo(imageView.snp.centerY)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.trailing.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
        
        agreeButton.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.trailing.equalTo(deleteButton.snp.leading).offset(-15)
            make.centerY.equalTo(deleteButton.snp.centerY)
        }
    }
}
