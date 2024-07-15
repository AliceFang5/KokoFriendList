//
//  FriendListTableViewCell.swift
//  KokoFriendList
//
//  Created by 方芸萱 on 2024/7/7.
//

import UIKit

class FriendListTableViewCell: UITableViewCell {
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icFriendsStar")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let avatarImageView: UIImageView = {
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
    
    private lazy var behaviorStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [transferMoneyButton,
                                                       duringInviteButton,
                                                       moreButton])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private let transferMoneyButton: UIButton = {
        let button = UIButton()
        button.setTitle("轉帳", for: .normal)
        button.setTitleColor(.hotPink, for: .normal)
        button.titleLabel?.font = UIFont.pingFangTC(size: 14, type: .medium)
        button.layer.borderWidth = 1.2
        button.layer.borderColor = UIColor.hotPink.cgColor
        button.layer.cornerRadius = 2
        return button
    }()
    
    private let duringInviteButton: UIButton = {
        let button = UIButton()
        button.setTitle("邀請中", for: .normal)
        button.setTitleColor(.lightGrey, for: .normal)
        button.titleLabel?.font = UIFont.pingFangTC(size: 14, type: .medium)
        button.layer.borderWidth = 1.2
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 2
        button.isHidden = true
        return button
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icFriendsMore"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateFriendInfo(info: FriendInfo) {
        
        starImageView.isHidden = info.isTop == "0"
        nameLabel.text = info.name
        
        let isDuringInvite = info.status == 2
        duringInviteButton.isHidden = !isDuringInvite
        moreButton.isHidden = isDuringInvite
    }
}

private extension FriendListTableViewCell {
    
    func setupUI() {
        addSubview(starImageView)
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(behaviorStackView)
        
        starImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(14)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.leading.equalTo(starImageView.snp.trailing).offset(6)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(15)
            make.centerY.equalToSuperview()
        }
        
        behaviorStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(24)
        }
        
        transferMoneyButton.snp.makeConstraints { make in
            make.width.equalTo(47)
        }
        
        duringInviteButton.snp.makeConstraints { make in
            make.width.equalTo(60)
        }
        
        moreButton.snp.makeConstraints { make in
            make.width.equalTo(47)
        }
    }
}
