//
//  BaseNavigationController.swift
//  PravicyPhoto
//
//  Created by HongXiangWen on 2018/1/6.
//  Copyright © 2018年 WHX. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.shadowImage = UIImage()
        isToolbarHidden = false
    }

}
