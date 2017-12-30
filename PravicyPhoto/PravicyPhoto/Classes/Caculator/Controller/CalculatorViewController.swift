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
        /// 设置ViewModel
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 隐藏导航条
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        calculatorVM.clear()
    }
    
}

// MARK: - 私有方法
extension CalculatorViewController {

    private func setupViewModel() {
        // 确定使用哪个VM
        switch viewType {
        case .Normal:
            if UserDefaults.standard.string(forKey: kUserPhotoPasswordKey) != nil {
                setupCalculatorViewModel()
            } else {
                setupPassBoardViewModel()
            }
        default:
            setupPassBoardViewModel()
        }
        // 显示回调
        calculatorVM.displayCallback = { text in
            self.displayLabel.text =  text
        }
    }
    
    private func setupCalculatorViewModel() {
        displayLabel.text = "0"
        calculatorVM = CalculatorViewModel()
        calculatorVM.targetVC = self
    }
    
    private func setupPassBoardViewModel() {
        displayLabel.text = kInputPasswordText
        calculatorVM = PassBoardViewModel()
        calculatorVM.targetVC = self
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



