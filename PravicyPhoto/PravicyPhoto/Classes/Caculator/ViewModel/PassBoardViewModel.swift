//
//  PassBoardViewModel.swift
//  PravicyPhoto
//
//  Created by HongXiangWen on 2017/12/29.
//  Copyright © 2017年 WHX. All rights reserved.
//

import UIKit

class PassBoardViewModel: NSObject, CalaulatorProtocol {
    
    // MARK: - 公开属性
    var displayCallback: DisplayResult?
    var displayText: String = "" {
        didSet {
            guard let displayCallback = displayCallback else { return }
            displayCallback(displayText)
        }
    }
    
    // MARK: - 公开方法
    /// 输入数字
    func inputDigit(_ digit: String) {
        
    }
    
    /// 输入运算符
    func inputSymbol(_ symbol: String) {
       
    }
    
    /// 输入小数点
    func inputDecimal() {
       
    }
    
    /// 清空
    func clear() {
        
    }
    
}

