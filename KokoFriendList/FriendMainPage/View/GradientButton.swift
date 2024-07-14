//
//  GradientButton.swift
//  KokoFriendList
//
//  Created by 方芸萱 on 2024/7/14.
//

import UIKit

class GradientButton: UIButton {
    
    override class var layerClass: AnyClass { return CAGradientLayer.self }
    private var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
    
    var _gradientLayer: CAGradientLayer
    
    init(_gradientLayer: CAGradientLayer) {
        self._gradientLayer = _gradientLayer
        super.init(frame: .zero)
        gradientConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func gradientConfig() {
        gradientLayer.locations = _gradientLayer.locations
        gradientLayer.colors = _gradientLayer.colors
        gradientLayer.startPoint = _gradientLayer.startPoint
        gradientLayer.endPoint = _gradientLayer.endPoint
    }
}
