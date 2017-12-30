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
    var targetVC: UIViewController?
    var displayCallback: DisplayResult?
    var displayText: String = "" {
        didSet {
            guard let displayCallback = displayCallback else { return }
            displayCallback(displayText)
        }
    }
    
    // MARK: - 私有属性
    private var pwdText: String = ""
    private var isRepeatInput: Bool = false
    private var numIsInputing = false

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
        if symbol == "=" {
            if isRepeatInput {
                if displayText == pwdText {
                    setPasswordSucceeded()
                } else {
                    if validateInput() {
                        clearWithText(kValidateErrorText)
                    }
                }
            } else {
                if validateInput() {
                    numIsInputing = false
                    isRepeatInput = true
                    pwdText = displayText
                    displayText = kRepeatPasswordText
                }
            }
        } else {
            popToRootVC()
        }
    }
    
    /// 输入小数点
    func inputDecimal() {

    }
    
    /// 清空
    func clear() {
        clearWithText(kInputPasswordText)
    }
    
    /// 设置成功
    func setPasswordSucceeded() {
        if UserDefaults.standard.string(forKey: kUserPhotoPasswordKey) != nil {
            UserDefaults.standard.set(pwdText, forKey: kUserPhotoPasswordKey)
            popToRootVC()
        } else {
            UserDefaults.standard.set(pwdText, forKey: kUserPhotoPasswordKey)
            pushToRootVC()
        }
    }
    
    // MARK: - 私有方法
    /// 判断验证输入
    private func validateInput() -> Bool {
        if  displayText != kInputPasswordText &&
            displayText != kRepeatPasswordText &&
            displayText != kValidateErrorText {
            return true
        }
        return false
    }
    
    /// 清空数据
    private func clearWithText(_ text: String) {
        numIsInputing = false
        isRepeatInput = false
        pwdText = ""
        displayText = text
    }
    
}




