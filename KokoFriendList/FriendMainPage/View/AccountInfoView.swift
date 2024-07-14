//
//  AccountInfoView.swift
//  KokoFriendList
//
//  Created by 方芸萱 on 2024/7/7.
//

import UIKit
import SnapKit

class AccountInfoView: UIView {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .greyishBrown
        label.font = UIFont.pingFangTC(size: 17, type: .medium)
        return label
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.textColor = .greyishBrown
        label.font = UIFont.pingFangTC(size: 13)
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "imgFriendsFemaleDefault")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateAccountInfo(_ accountInfo: AccountInfo) {
        nameLabel.text = accountInfo.name
        idLabel.text = "KOKO ID：\(accountInfo.kokoid) >"
    }
}

private extension AccountInfoView {
    
    func setupUI() {
        
        addSubview(nameLabel)
        addSubview(idLabel)
        addSubview(imageView)
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.bottom.equalTo(imageView.snp.centerY)
        }
        
        idLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.left)
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(52)
            make.height.equalTo(54)
            make.trailing.equalToSuperview().inset(30)
            make.centerY.equalToSuperview()
        }
    }
}
