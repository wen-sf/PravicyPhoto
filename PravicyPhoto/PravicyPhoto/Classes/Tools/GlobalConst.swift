//
//  GlobalConst.swift
//  PravicyPhoto
//
//  Created by HongXiangWen on 2017/12/29.
//  Copyright © 2017年 WHX. All rights reserved.
//

import Foundation
import UIKit

// MARK: - APP

/// appDelegate
let appDelegate = UIApplication.shared.delegate as! AppDelegate

/// 屏幕宽
let kScreenWidth = UIScreen.main.bounds.width

/// 屏幕高
let kScreenHeight = UIScreen.main.bounds.height


// MARK: - UserDefault

/// 相册密码
let kUserPhotoPasswordKey = "kUserPhotoPasswordKey"


// MARK: - 提示文案

/// 输入密码
let kInputPasswordText = "请输入密码，按“=“确定"

/// 重复密码
let kRepeatPasswordText = "请再次输入密码"

/// 密码验证错误
let kValidateErrorText = "两次密码不一样，请重输"


