//
//  CalculatorServer.swift
//  PravicyPhoto
//
//  Created by HongXiangWen on 2017/12/29.
//  Copyright © 2017年 WHX. All rights reserved.
//

import UIKit

// MARK: - 运算枚举
private enum CalculatorOperation {
    /// 常量计算
    case ConstantOperation(Double)
    /// 一元运算
    case UnaryOperation((Double) -> Double)
    /// 二元运算
    case BinaryOperation((Double, Double) -> Double)
    /// 求结果
    case EqualOperation
}

// MARK: - 操作流
private struct PendingBinaryOperationInfo {
    var function : (Double, Double) -> Double
    var firstOperand : Double
}

// MARK: - 计算器处理
class CalculatorServer {
    
    // MARK: - 公开属性
    var result: Double {
        return accumulator
    }
    
    // MARK: - 私有属性
    private var accumulator: Double = 0.0
    
    private let operations: Dictionary<String, CalculatorOperation> = [
        "+": .BinaryOperation({$0 + $1}),
        "−": .BinaryOperation({$0 - $1}),
        "×": .BinaryOperation({$0 * $1}),
        "÷": .BinaryOperation({$0 / $1}),
        "±": .UnaryOperation({-$0}),
        "﹪": .UnaryOperation({$0 / 100}),
        "=": .EqualOperation
    ]
    
    private var pending : PendingBinaryOperationInfo?
    
    // MARK: - 公开方法
    /// 输入数字
    func setInputOperand(_ operand: Double) {
        accumulator = operand
    }
    
    /// 运算操作
    func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .ConstantOperation(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(function: function ,firstOperand: accumulator)
            case .EqualOperation:
                executePendingBinaryOperation()
            }
        }
    }
    
    /// 清零
    func clear() {
        accumulator = 0.0
        pending = nil
    }
    
    
    // MARK: - 私有方法
    /// 运算结果
    private func executePendingBinaryOperation() {
        if pending != nil{
            accumulator = pending!.function(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
}


