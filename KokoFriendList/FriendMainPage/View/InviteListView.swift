//
//  InviteListView.swift
//  KokoFriendList
//
//  Created by 方芸萱 on 2024/7/8.
//

import UIKit
import SnapKit

class InviteListView: UIView {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateInfoList(infoList: [FriendInfo]) {
        
        infoList.forEach { info in
            let infoView = InviteInfoView(info: info)
            stackView.addArrangedSubview(infoView)
        }
    }
}

private extension InviteListView {
    
    func setupUI() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(15)
            make.leading.trailing.equalToSuperview()
        }
    }
}
