//
//  UIFontExtension.swift
//  KokoFriendList
//
//  Created by 方芸萱 on 2024/7/7.
//

import UIKit

extension UIFont {
    
    static func pingFangTC(size: CGFloat, type: FontType = .regular) -> UIFont {
        switch type {
        case .regular:
            return UIFont(name: "PingFangTC-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
        case .semibold:
            return UIFont(name: "PingFangTC-Semibold", size: size) ?? UIFont.systemFont(ofSize: size)
        case .medium:
            return UIFont(name: "PingFangTC-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
            
        }
    }
    
    enum FontType {
        case regular
        case semibold
        case medium
    }
}
