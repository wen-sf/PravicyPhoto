//
//  CalaulatorProtocol.swift
//  PravicyPhoto
//
//  Created by HongXiangWen on 2017/12/29.
//  Copyright © 2017年 WHX. All rights reserved.
//

import Foundation
import UIKit

typealias DisplayResult = (_ text: String) -> ()

protocol CalaulatorProtocol {
    
    // MARK: - 公开属性
    /// 输出回调
    var displayCallback: DisplayResult? { get set }
    /// 输出的文字
    var displayText: String { get }
    /// 目标VC
    var targetVC: UIViewController? { get set }
    
    // MARK: - 公开方法
    /// 输入数字
    func inputDigit(_ digit: String)
    
    /// 输入运算符
    func inputSymbol(_ symbol: String)
    
    /// 输入小数点
    func inputDecimal()
    
    /// 清空
    func clear()
    
}

extension CalaulatorProtocol {
    
    /// 跳转
    func pushToRootVC() {
        guard let targetVC = targetVC else { return }
        let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RootNavigationController")
        targetVC.present(rootVC, animated: false, completion: nil)
    }
    
    func popToRootVC() {
        guard let targetVC = targetVC else { return }
        targetVC.navigationController?.popViewController(animated: true)
    }
    
}


