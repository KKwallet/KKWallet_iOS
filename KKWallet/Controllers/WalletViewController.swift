//
//  WalletViewController.swift
//  KKWallet
//
//  Created by 曹茂鑫 on 2018/5/17.
//  Copyright © 2018年 Caomaoxin. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController {

    @IBOutlet weak var addressLabel: UILabel!
    
    var address: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addressLabel.text = address
    }
}
