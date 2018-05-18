//
//  CreateWalletViewController.swift
//  KKWallet
//
//  Created by 曹茂鑫 on 2018/5/17.
//  Copyright © 2018年 Caomaoxin. All rights reserved.
//

import UIKit
import SVProgressHUD

class CreateWalletViewController: UIViewController {

    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var repeatPasswordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func createWallet(_ sender: UIButton) {
        
        let confirm = UIAlertAction(title: "确定", style: .default, handler: nil)
        guard !(passwordTF.text?.isEmpty)! else {
            
            let artVC = UIAlertController(title: "提示", message: "密码不能为空", preferredStyle: .alert)
            artVC.addAction(confirm)
            self.present(artVC, animated: true, completion: nil)
            return
        }
        
        guard passwordTF.text == repeatPasswordTF.text else {
            
            let artVC = UIAlertController(title: "提示", message: "两次输入的密码不一致", preferredStyle: .alert)
            artVC.addAction(confirm)
            self.present(artVC, animated: true, completion: nil)
            return
        }
        
        SVProgressHUD.show()
        // 创建助记词
        WalletTools.generateMnemonic { (mnemonic) in
            
            // 通过助记词导入钱包
            WalletTools.importMnemonicAsync(mnemonic: mnemonic, password: self.passwordTF.text!, devirationPath: WalletTools.defaultDerivationPath, completion: { (result) in
                
                SVProgressHUD.dismiss()
                switch result {
                case .succeed(let account):
                    
                    SVProgressHUD.showSuccess(withStatus: "钱包创建成功")
                    
                    let walletVC = WalletViewController()
                    walletVC.address = account.address.eip55String
                    self.navigationController?.pushViewController(walletVC, animated: true)
                    
                case .failed(_, let errorMessage):
                    SVProgressHUD.showError(withStatus: errorMessage)
                }
            })
        }
    }
}
