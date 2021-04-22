//
//  UILayer+Extension.swift
//  VocabularyDemo
//
//  Created by joey on 4/22/21.
//  Copyright © 2021 Yi Zhang. All rights reserved.
//

import UIKit

public extension CALayer {
    func sketchShadow(color: UIColor = .black, alpha: Float, x: CGFloat, y: CGFloat, blur: CGFloat, spread: CGFloat = 0) {
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
