//
//  ViewController.swift
//  MEMOment
//
//  Created by Geon Kang on 2020/09/14.
//  Copyright © 2020 Geon Kang. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialBottomSheet

class ViewController: UIViewController {
    
   
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "MemoListVC") as! MemoListVC
        let btmSheet : MDCBottomSheetController = MDCBottomSheetController(contentViewController: vc)
        btmSheet.preferredContentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height * 0.52)
        btmSheet.delegate = self
        btmSheet.dismissOnBackgroundTap = false
        btmSheet.dismissOnDraggingDownSheet = false
        present(btmSheet, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
      
    }


    
}
extension ViewController: MDCBottomSheetControllerDelegate {
    
}
