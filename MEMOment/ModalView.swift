//
//  ModalView.swift
//  MEMOment
//
//  Created by Geon Kang on 2020/09/14.
//  Copyright © 2020 Geon Kang. All rights reserved.
//

import UIKit
import BottomHalfModal

class ModalView: UIViewController, SheetContentHeightModifiable {
    
    var sheetContentHeightToModify: CGFloat = SheetContentHeight.default
    init() {
        super.init(nibName: nil, bundle: Bundle(for: ModalView.self))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init (coder: ) has not been impelemented")
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(close))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        adjustFrameToSheetContentHeightIfNeeded()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        adjustFrameToSheetContentHeightIfNeeded(with: coordinator)
    }

    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
}
