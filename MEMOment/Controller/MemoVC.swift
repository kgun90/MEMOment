//
//  MemoVC.swift
//  MEMOment
//
//  Created by Geon Kang on 2020/11/19.
//  Copyright © 2020 Geon Kang. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift

protocol memoDelegate {
    func getCalendarEvent()
}

class MemoVC: UIViewController {
    lazy var memoTable: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.allowsSelection = true
        
        return table
    }()
    
    private var dateData: [String] = []
    var date = Date()
    var memoData: Results<MemoData>!
    let realm = try! Realm()
    var delegate: memoDelegate? 

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        memoData = realm.objects(MemoData.self).sorted(byKeyPath: "date", ascending: true)
        
        memoTable.delegate = self
        memoTable.dataSource = self
         
        memoTable.register(UINib(nibName: "MemoListCell", bundle: nil), forCellReuseIdentifier: "MemoListCell")
        
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        getMemoData()
    }
    func layout() {
        self.view.addSubview(memoTable)
        
        memoTable.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
    func getMemoData() {
        
        let today = self.date.startOfDay as NSDate
        let endOfDay = self.date.endOfDay as NSDate
        
        let predicate = NSPredicate(format: "date BETWEEN {%@, %@}", today, endOfDay)
        // 선택 한 날짜를 받아 NSDate 형태로 초기화 하여 NSPredicate 문으로 Query 작성
        memoData = realm.objects(MemoData.self).sorted(byKeyPath: "date", ascending: true).filter(predicate)
        // 이를 통해 필터 한 결과 만 표시하는 형태, Realm 에서는 NSDate 형태로만 Predicate를 통해 Query 작성이 가능하다.
        self.memoTable.reloadData()
       
    }
    
    func deleteAlert(title: String, message: String, indexPath: IndexPath) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "네", style: .default) { (action) in
            
            self.deleteAction(indexPath)
            self.delegate?.getCalendarEvent()
        }
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(okButton)
        alertController.addAction(cancelButton)
        
        return self.present(alertController, animated: true, completion: nil)
    }
    func deleteAction(_ indexPath: IndexPath) {
        try! realm.write {
            let item = memoData[indexPath.row]
            realm.delete(item)
        }
        memoTable.deleteRows(at: [indexPath], with: .bottom)
       
        getMemoData()
    }
    
}

extension MemoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoListCell", for: indexPath as IndexPath) as! MemoListCell
       
        let data = memoData[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        cell.timeLabel.text = dateFormatter.string(from: data.date)
        cell.contentLabel.text = data.memo
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let write = WriteVC()
        write.modalPresentationStyle = .fullScreen
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        
        write.dateLabel.text = dateFormatter.string(from: memoData[indexPath.row].date)
        
        write.updateDate = memoData[indexPath.row].date        
        write.updateID = memoData[indexPath.row].id
        
        present(write, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    } // Edit 모드 사용여부(Swipe 등)
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    } // .none으로 설정할 경우 Edit mode에서 삭제버튼을 숨길 수 있으나, Swipe 로 삭제 기능이 동작하지 않는다.
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteAlert(title: "삭제", message: "메모를 삭제하시겠습니까?", indexPath: indexPath)
        }
       
    } // TableView Cell Swipe하여 삭제
}
