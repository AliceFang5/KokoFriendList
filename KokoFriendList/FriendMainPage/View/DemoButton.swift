//
//  DemoButton.swift
//  KokoFriendList
//
//  Created by 方芸萱 on 2024/7/15.
//

import UIKit

class DemoButton: UIButton {
    
    let demoType: DemoType
    
    init(demoType: DemoType) {
        self.demoType = demoType
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isSelect(_ isSelect: Bool) {
        backgroundColor = isSelect ? .lightGrey : .whiteThree
    }
}

private extension DemoButton {
    
    func setupUI() {
        setTitle(demoType.getTitle(), for: .normal)
        setTitleColor(.greyishBrown, for: .normal)
        titleLabel?.font = UIFont.pingFangTC(size: 16, type: .medium)
        layer.borderColor = UIColor.greyishBrown.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 16
    }
}
