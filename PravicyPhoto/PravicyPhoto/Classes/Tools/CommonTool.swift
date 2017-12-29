//
//  CommonTool.swift
//  PravicyPhoto
//
//  Created by HongXiangWen on 2017/12/29.
//  Copyright © 2017年 WHX. All rights reserved.
//

import UIKit
import Foundation

class CommonTool {

    /// 去小数点后的0
    class func deleteTheZeroAfterDecimal(_ inputNumber: String) -> String {
        let inNum = inputNumber as NSString
        var outNum = inNum
        var i = 1
        if inNum.contains(".") {
            while i < inNum.length {
                if outNum.hasSuffix("0") {
                    outNum = outNum.substring(to: outNum.length-1) as NSString
                    i = i + 1
                } else {
                    break
                }
            }
            if outNum.hasSuffix(".") {
                outNum = outNum.substring(to: outNum.length-1) as NSString
            }
            return outNum as String
        } else {
            return inNum as String
        }
    }
    
}

