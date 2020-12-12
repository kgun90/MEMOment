//
//  UIFont.swift
//  MEMOment
//
//  Created by Geon Kang on 2020/11/19.
//  Copyright © 2020 Geon Kang. All rights reserved.
//

import UIKit

extension UIFont {
    public enum FontType: String {
        case bold = "Bold"
        case medium = "Medium"
        case regular = "Regular"
        case semiBold = "SemiBold"
    
    }

    static func SDGothic(_ type: FontType, size: CGFloat) -> UIFont {
        return UIFont(name: "AppleSDGothicNeo-\(type.rawValue)", size: size)!
    }
    
    static func Nanum(size: CGFloat) -> UIFont {
        return UIFont(name: "NanumBarunpen", size: size)!
    }
    
}
