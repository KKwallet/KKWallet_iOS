//
//  ImportWalletViewController.swift
//  KKWallet
//
//  Created by 曹茂鑫 on 2018/5/17.
//  Copyright © 2018年 Caomaoxin. All rights reserved.
//

import UIKit
import SVProgressHUD


enum WalletImportType {
    case mnemonic
    case privateKey
}

class ImportWalletViewController: UIViewController {

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var textView: UITextView!
    
    let mnemonicString = "warfare only subject destroy movie opinion magnet tired butter sort skirt lobster"
    let privateKey = "3a1076bf45ab87712ad64ccb3b10217737f7faacbf2872e88fdd9a537d8fe266"
    
    var importType: WalletImportType = .mnemonic
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textView.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        
        switch sender.numberOfSegments {
        case 1:
            self.importType = .mnemonic
        case 2:
            self.importType = .privateKey
        default: break
        }
    }
    

    @IBAction func importWallet(_ sender: UIButton) {
     
        let confirm = UIAlertAction(title: "确定", style: .default, handler: nil)
        guard !(self.textView.text.isEmpty) else {
            
            let artVC = UIAlertController(title: "提示", message: "助记词/私钥 不能为空", preferredStyle: .alert)
            artVC.addAction(confirm)
            self.present(artVC, animated: true, completion: nil)
            return
        }
        
        SVProgressHUD.show()
        var importResult: ImportType
        
        switch self.importType {
        case .mnemonic:
            
            importResult = ImportType.mnemonic(mnemonic: self.textView.text, password: "password", derivationPath: WalletTools.defaultDerivationPath)
            
        case .privateKey:
            
            importResult = ImportType.privateKey(privateKey: self.textView.text, password: "password")
        }
        
        WalletTools.importWallet(with: importResult) { (result) in
            
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
        }
    }
}

























