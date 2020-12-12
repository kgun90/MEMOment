//
//  WriteVC.swift
//  MEMOment
//
//  Created by Geon Kang on 2020/11/19.
//  Copyright © 2020 Geon Kang. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift

protocol dismissDelegate {
    func getCalendarEvent()
}

class WriteVC: UIViewController {
    
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var topViewLabel: UILabel = {
        let label = UILabel()
        label.text = "모먼트 작성"
        label.font = .Nanum(size: 24)
        label.textColor = .salmon
        return label
    }()
    
    lazy var topViewDisimssButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .salmon
        button.addTarget(self, action: #selector(didmissAction), for: .touchUpInside)
        return button
    }()
    
    lazy var topViewWriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .salmon
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(writeButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .Nanum(size: 24)
        label.textColor = .warmGray
        
        return label
    }()


    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .warmGray
        
        return view
    }()
    
    lazy var memoTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .warmGray
        textView.isScrollEnabled = false
        textView.font = .Nanum(size: 18)
        return textView
    }()
    
    lazy var typeCountLabel: UILabel = {
        let label = UILabel()
        label.font = .Nanum(size: 16)
        label.textColor = .warmGray
        
        return label
    }()
        
    let realm = try! Realm()
    var delegate: dismissDelegate?
    var updateID: Int?
    var updateDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        memoTextView.delegate = self

        textViewDidChange(memoTextView)
        addView()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let id = updateID {
            let target = realm.object(ofType: MemoData.self, forPrimaryKey: id)
            memoTextView.text = target?.memo
        }
        typeCountLabel.text = "\(memoTextView.text.count) / 400"
    }
    
    
    @objc func didmissAction() {
        self.dismiss(animated: true, completion: nil)
        self.memoTextView.text = ""
    }
    
    func storeData() {
        if !memoTextView.text.isEmpty {
            let memoData = MemoData()
            if let id = updateID {
                memoData.id = id
                memoData.date = updateDate ?? Date()
            } else {
                memoData.id = (Array(realm.objects(MemoData.self)).last?.id ?? 0) + 1
                memoData.date = Date()
            }
          
            memoData.memo = memoTextView.text
            
            try! realm.write {
                realm.add(memoData, update: .modified)
            }
        }
  
    }
    
    func memoAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "네", style: .default) { (action) in
            
            self.dismiss(animated: true, completion: nil)
            if !self.memoTextView.text.isEmpty {
                self.storeData()
            }
            self.delegate?.getCalendarEvent()
            self.memoTextView.text = ""
        }
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(okButton)
        alertController.addAction(cancelButton)
        
        return self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func writeButtonAction() {
        if memoTextView.text.isEmpty {
            memoAlert(title: "메모가 비었습니다.", message: "메모를 그만 작성할까요?")
        } else {
            memoAlert(title: "메모 작성", message: "메모를 저장할까요?")
        }

    }
    
    func addView() {
        view.addSubview(topView)
        topView.addSubview(topViewDisimssButton)
        topView.addSubview(topViewLabel)
        topView.addSubview(topViewWriteButton)
        
        view.addSubview(dateLabel)
        view.addSubview(lineView)
        view.addSubview(memoTextView)
        view.addSubview(typeCountLabel)
    }
    
    func layout() {
        topView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Device.statusBarHeight)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(Device.navigationBarHeight)
        }
        
        topViewDisimssButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(18)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }

        topViewLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        topViewWriteButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-18)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
            
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(topView.snp.bottom).offset(13.5)
        }
        
        typeCountLabel.snp.makeConstraints {
            $0.bottom.equalTo(dateLabel.snp.bottom)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(30)
        }
        
        
        lineView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(140)
            $0.height.equalTo(1)
            $0.top.equalTo(dateLabel.snp.bottom).offset(10)
        }
        
        memoTextView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Device.screenHeight * 0.20)
            $0.leading.equalToSuperview().offset(18)
            $0.trailing.equalToSuperview().offset(-18)
            $0.bottom.equalToSuperview().offset(-12)
            $0.height.equalTo(Device.screenHeight * 0.6)
        }

    }
}

extension WriteVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
        typeCountLabel.text = "\(textView.text.count) / 400"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars < 401
        // 입력 글자 수 제한
    }
}
