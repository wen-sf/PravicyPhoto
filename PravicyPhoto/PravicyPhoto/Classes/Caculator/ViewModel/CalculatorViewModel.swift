//
//  CalculatorViewModel.swift
//  PravicyPhoto
//
//  Created by HongXiangWen on 2017/12/29.
//  Copyright © 2017年 WHX. All rights reserved.
//

import UIKit

class CalculatorViewModel: NSObject, CalaulatorProtocol {
    
    // MARK: - 公开属性
    var targetVC: UIViewController?
    var displayCallback: DisplayResult?
    var displayText: String = "0" {
        didSet {
            guard let displayCallback = displayCallback else { return }
            displayCallback(displayText)
        }
    }

    // MARK: - 私有属性
    private let calculatorServer: CalculatorServer = CalculatorServer()
    private var numIsInputing = false
    
    private var displayValue: Double {
        set {
            displayText = CommonTool.deleteTheZeroAfterDecimal(String(newValue))
        }
        get {
            guard let value = Double(displayText) else { return 0 }
            return value
        }
    }
    
    // MARK: - 公开方法
    /// 输入数字
    func inputDigit(_ digit: String) {
        if numIsInputing {
            if Double(displayText) == 0 {
                if Double(digit) == 0 {
                    numIsInputing = false
                } else {
                    displayText = digit
                }
                return
            }
            displayText += digit
        } else {
            displayText = digit
        }
        numIsInputing = true
    }
   
    /// 输入运算符
    func inputSymbol(_ symbol: String) {
        if symbol == "=" && displayText == (UserDefaults.standard.string(forKey: kUserPhotoPasswordKey)) {
            pushToRootVC()
            return
        }
        
        if numIsInputing {
            calculatorServer.setInputOperand(displayValue)
            numIsInputing = false
        }
        calculatorServer.performOperation(symbol)
        displayValue = calculatorServer.result
    }
    
    /// 输入小数点
    func inputDecimal() {
        if displayText.contains(".") {
            return
        }
        displayText += "."
        numIsInputing = true
    }
    
    /// 清空
    func clear() {
        calculatorServer.clear()
        numIsInputing = false
        displayValue = calculatorServer.result
    }
    
    
}
