//
//  CalendarVC.swift
//  MEMOment
//
//  Created by Geon Kang on 2020/12/06.
//  Copyright © 2020 Geon Kang. All rights reserved.
//

import UIKit
import SnapKit
import FSCalendar
import FittedSheets
import RealmSwift

class CalendarVC: UIViewController, dismissDelegate, memoDelegate {

//    @IBOutlet weak var calendar: FSCalendar!
    
    lazy var calendar: FSCalendar = {
        let cal = FSCalendar()
        cal.appearance.selectionColor = .salmon

        cal.select(Date())
        cal.appearance.todayColor = .gaenari
        cal.appearance.titleTodayColor = .black
        cal.appearance.borderRadius = 0.65
        
        cal.appearance.headerTitleColor = .salmon
        cal.appearance.headerTitleFont = .SDGothic(.medium, size: 23)
        cal.appearance.headerDateFormat = "yyyy MMMM"
        cal.appearance.caseOptions = FSCalendarCaseOptions.headerUsesUpperCase
        
        
        cal.appearance.weekdayTextColor = UIColor(hex: 0x808080)
        cal.appearance.weekdayFont = .SDGothic(.medium, size: 15)
        cal.calendarWeekdayView.weekdayLabels.forEach {
            $0.text = $0.text?.uppercased()
        }
        
        cal.appearance.eventDefaultColor = .salmon
        cal.appearance.eventSelectionColor = .white
        
        return cal
    }()
    
    lazy var writeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(moveToWrite), for: .touchUpInside)
        return button
    }()
    
    let memoListView = MemoVC()
    var memoDates: [Date] = []
    let realm = try! Realm()
    var totalData: Results<MemoData>!
    let write = WriteVC()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        getCalendarEvent()
        calendar.delegate = self
        calendar.dataSource = self
        write.delegate = self
        memoListView.delegate = self
        
        layout()
        callSheet()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
      
    }
   
    func getCalendarEvent() {
        memoDates.removeAll()
        totalData = realm.objects(MemoData.self).sorted(byKeyPath: "date", ascending: true)
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
       
        for i in 0 ..< totalData.count {
            memoDates.append(formatter.date(from: formatter.string(from: totalData[i].date))!)
            print(memoDates)
        }
        
        calendar.reloadData()
  
    }
    
    func layout() {
        view.addSubview(calendar)
        calendar.addSubview(writeButton)
        
        calendar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Device.statusBarHeight)
            $0.bottom.equalToSuperview().offset(-(Device.screenHeight * 0.5))
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        writeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-62)
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
        
    }
    
    func callSheet() {
        let sheet = bottomSheet(useInlineMode: true)
        
        sheet.willMove(toParent: self)
        self.addChild(sheet)
        self.view.addSubview(sheet.view)
        sheet.didMove(toParent: self)
        
        sheet.view.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        sheet.didDismiss = { [weak self] _ in
            self?.view.removeFromSuperview()
            
        }
        sheet.shouldDismiss = { _ in
            print("should dismiss")
            return true
        }
        
        // animate in
        sheet.animateIn()
    }
    
    func bottomSheet(useInlineMode: Bool) -> SheetViewController {
    
        let sheet = SheetViewController(controller: memoListView, sizes: [.percent(0.5), .percent(0.95)], options: SheetOptions(useInlineMode: useInlineMode))
        
        sheet.dismissOnPull = false
        sheet.dismissOnOverlayTap = false
        sheet.overlayColor = .clear
        
        sheet.contentViewController.view.layer.shadowColor = UIColor.black.cgColor
        sheet.contentViewController.view.layer.shadowOpacity = 0.1
        sheet.contentViewController.view.layer.shadowRadius = 10
        sheet.allowGestureThroughOverlay = true
        sheet.shouldRecognizePanGestureWithUIControls = false
   
        
        return sheet
    }
    
    @objc func moveToWrite() {
        write.modalPresentationStyle = .fullScreen
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        
        write.dateLabel.text = dateFormatter.string(from: Date())
        
        present(write, animated: true, completion: nil)
    }

}
extension CalendarVC: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        memoListView.date = date
        memoListView.getMemoData()
        
    } // Calendar 날짜 선택시 발생이벤트, date 통해 날짜를 전달한다
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.memoDates.contains(date) {
            return 1
        }
        return 0
    }
}
