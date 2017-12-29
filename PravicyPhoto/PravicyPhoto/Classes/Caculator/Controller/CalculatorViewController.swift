//
//  CalculatorViewController.swift
//  PravicyPhoto
//
//  Created by HongXiangWen on 2017/12/29.
//  Copyright © 2017年 WHX. All rights reserved.
//

import UIKit

enum CalculatorViewControllerType {
    /// 正常计算器
    case Normal
    /// 密码输入板
    case PassBoard
}

class CalculatorViewController: UIViewController {

    // MARK: - 公开属性
    @IBOutlet weak var displayLabel: UILabel!
    
    var viewType: CalculatorViewControllerType = .Normal
    
    // MARK: - 私有属性
    private var calculatorVM: CalaulatorProtocol!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
    }
    
    // MARK: - 私有方法
    private func setupViewModel() {
        // 确定使用哪个VM
        switch viewType {
        case .Normal:
            if UserDefaults.standard.string(forKey: kUserPhotoPasswordKey) != nil {
                calculatorVM = CalculatorViewModel()
                displayLabel.text = "0"
            } else {
                calculatorVM = PassBoardViewModel()
                displayLabel.text = "请输入密码，按“=“确定"
            }
        default:
            displayLabel.text = "请输入密码，按“=“确定"
            calculatorVM = PassBoardViewModel()
        }
        // 显示回调
        calculatorVM.displayCallback = { text in
            self.displayLabel.text =  text
        }
    }
}

// MARK: - Actions
extension CalculatorViewController {
    
    @IBAction func digitClickAction(_ sender: UIButton) {
        calculatorVM.inputDigit(sender.currentTitle!)
    }
    
    @IBAction func symbolClickAction(_ sender: UIButton) {
        calculatorVM.inputSymbol(sender.currentTitle!)
    }
    
    @IBAction func decimalClickAction(_ sender: UIButton) {
        calculatorVM.inputDecimal()
    }
    
    @IBAction func clearClickAction(_ sender: UIButton) {
        calculatorVM.clear()
    }
    
}



