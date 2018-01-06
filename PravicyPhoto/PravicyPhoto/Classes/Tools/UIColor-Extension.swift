//
//  UIColor-Extension.swift
//  PravicyPhoto
//
//  Created by HongXiangWen on 2018/1/6.
//  Copyright © 2018年 WHX. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func color(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    class func color(withHexColor hexColor:Int64) -> UIColor {
        let r = CGFloat((hexColor & 0xFF0000) >> 16)
        let g = CGFloat((hexColor & 0xFF00) >> 8)
        let b = CGFloat(hexColor & 0xFF)
        return UIColor.color(r: r, g: g, b: b)
    }
    
    class func randomColor() -> UIColor {
        return UIColor.color(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    class func themeColor() -> UIColor {
        return UIColor.color(withHexColor: 0x00c1d5)
    }
    
}


