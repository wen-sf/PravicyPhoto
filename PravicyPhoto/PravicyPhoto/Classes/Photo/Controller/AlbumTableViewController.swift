//
//  AlbumTableViewController.swift
//  PravicyPhoto
//
//  Created by HongXiangWen on 2017/12/30.
//  Copyright © 2017年 WHX. All rights reserved.
//

import UIKit

class AlbumTableViewController: UITableViewController {

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 隐藏导航条
        navigationController?.setNavigationBarHidden(false, animated: true)
    }


}

// MARK: - Actions
extension AlbumTableViewController {
    
    @IBAction func resetAction(_ sender: UIBarButtonItem) {
        guard let calculatorVC = storyboard?.instantiateViewController(withIdentifier: "CalculatorViewController") as? CalculatorViewController else { return }
        calculatorVC.viewType = .PassBoard
        navigationController?.pushViewController(calculatorVC, animated: true)
    }
    
}



