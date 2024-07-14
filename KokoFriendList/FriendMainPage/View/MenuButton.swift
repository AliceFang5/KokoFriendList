//
//  MenuButton.swift
//  KokoFriendList
//
//  Created by 方芸萱 on 2024/7/11.
//

import UIKit
import SnapKit

class MenuButton: UIButton {
    
    private let menuLabel: UILabel = {
        let label = UILabel()
        label.textColor = .greyishBrown
        label.font = UIFont.pingFangTC(size: 13, type: .medium)
        return label
    }()
    
    private let notifyCountView: UIView = {
        let view = UIView()
        view.backgroundColor = .softPink
        view.layer.cornerRadius = 9
        view.isHidden = true
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private let notifyCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .whiteThree
        label.font = UIFont.pingFangTC(size: 12, type: .medium)
        label.isHidden = true
        return label
    }()
    
    private let underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .hotPink
        view.isHidden = true
        view.layer.cornerRadius = 2
        return view
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        menuLabel.text = title
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isSelect(_ isSelect: Bool) {
        underLineView.isHidden = !isSelect
    }
    
    func updateNotifyCount(_ notifyCount: Int) {
        
        let isNeedCount = notifyCount > 0
        notifyCountLabel.isHidden = !isNeedCount
        notifyCountView.isHidden = !isNeedCount
        
        let notifyCountString = notifyCount > 99 ? "99+" : String(notifyCount)
        notifyCountLabel.text = notifyCountString
    }
}

private extension MenuButton {
    
    func setupUI() {
        addSubview(menuLabel)
        addSubview(notifyCountView)
        addSubview(notifyCountLabel)
        addSubview(underLineView)
        
        menuLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(6)
        }
        
        notifyCountView.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(18)
            make.height.equalTo(18)
            make.centerY.equalTo(notifyCountLabel.snp.centerY)
            make.leading.equalTo(notifyCountLabel.snp.leading).offset(-5)
            make.trailing.equalTo(notifyCountLabel.snp.trailing).offset(5)
        }
        
        notifyCountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalTo(menuLabel.snp.trailing).offset(2)
            make.trailing.equalToSuperview().offset(-6)
            make.centerY.equalTo(menuLabel.snp.top).offset(-4)
        }
        
        underLineView.snp.makeConstraints { make in
            make.height.equalTo(4)
            make.leading.equalTo(menuLabel.snp.leading).offset(4)
            make.trailing.equalTo(menuLabel.snp.trailing).offset(-4)
            make.top.equalTo(menuLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
    }
}
