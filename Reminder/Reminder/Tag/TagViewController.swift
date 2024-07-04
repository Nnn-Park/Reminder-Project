//
//  TagViewController.swift
//  Reminder
//
//  Created by 박재형 on 7/3/24.
//

import UIKit
import SnapKit

class TagViewController: BaseViewController {
    
    let tagTextField: UITextField = {
        let textField = UITextField()
        
        textField.backgroundColor = UIColor.systemGray3
        textField.layer.cornerRadius = 10
        textField.leftViewMode = .always
        
        return textField
    }()
    
    
    override func configureHierarchy() {
        view.addSubview(tagTextField)
    }
    
    override func configureConstraints() {
        tagTextField.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.height.equalTo(40)
        }
    }
    
    override func configureView() {
        view.backgroundColor = UIColor.black
    }
    
}
