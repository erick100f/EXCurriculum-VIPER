//
//  UIVIew+Extension.swift
//  EXCurriculum
//
//  Created by Erick Cienfuegos on 10/12/19.
//  Copyright © 2019 Erick Cienfuegos. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class SemiCircleBackgroundView: UIView {

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(arcCenter: CGPoint(x: bounds.size.width / 2, y: bounds.size.height - bounds.size.width * 1.5  ), radius: bounds.size.width * 1.5, startAngle: 0.0, endAngle: .pi, clockwise: true)
        UIColor.lightGray.setFill()
        path.fill()
    }
}
