//
//  ViewController.swift
//  KKWallet
//
//  Created by 曹茂鑫 on 2018/5/17.
//  Copyright © 2018年 Caomaoxin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK:- 创建钱包
    @IBAction func createWallet(_ sender: UIButton) {
        
        self.navigationController?.pushViewController(CreateWalletViewController(), animated: true)
    }
    
    //MARK:- 导入钱包
    @IBAction func importWallet(_ sender: UIButton) {
        
        self.navigationController?.pushViewController(ImportWalletViewController(), animated: true)
    }
}

