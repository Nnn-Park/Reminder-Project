//
//  DateViewController.swift
//  Reminder
//
//  Created by 박재형 on 7/3/24.
//

import UIKit
import SnapKit
import Realm

final class DateViewController: BaseViewController {
    
    private let datePicker = UIDatePicker()
    
    override func viewWillAppear(_ animated: Bool) {
        configureView()
    }
    
    override func configureHierarchy() {
        view.addSubview(datePicker)
    }
    
    override func configureConstraints() {
        datePicker.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }
    }
    
    override func configureView() {
        view.backgroundColor = UIColor.black
        datePicker.backgroundColor = .white
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
    }
    
    @objc
    private func handleDatePicker(_ sender: UIDatePicker) {
        print(sender.date)
    }
}
