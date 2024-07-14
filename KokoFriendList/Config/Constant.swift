//
//  Constant.swift
//  KokoFriendList
//
//  Created by 方芸萱 on 2024/7/14.
//

import UIKit

class Constant {
    
    static let buttonGradientLayer: CAGradientLayer = {
        let buttonGradientLayer = CAGradientLayer()
        buttonGradientLayer.colors = [UIColor.frogGreen.cgColor, UIColor.booger.cgColor]
        buttonGradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        buttonGradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        buttonGradientLayer.locations = [0.5]
        return buttonGradientLayer
    }()
}
