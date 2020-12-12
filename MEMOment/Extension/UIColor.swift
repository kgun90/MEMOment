//
//  UIColor.swift
//  MEMOment
//
//  Created by Geon Kang on 2020/11/18.
//  Copyright © 2020 Geon Kang. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    // MARK: 메인 테마 색 또는 자주 쓰는 색을 정의
    // ex. label.textColor = .mainOrange
    class var warmGray: UIColor { UIColor(hex: 0x808080, alpha: 1)}
    class var salmon: UIColor { UIColor(hex: 0xf77a7a, alpha: 1)}
    class var gaenari: UIColor { UIColor(hex: 0xf7e600, alpha: 0.85)}

}

