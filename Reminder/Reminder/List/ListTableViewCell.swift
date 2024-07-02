//
//  ListTableViewCell.swift
//  Reminder
//
//  Created by 박재형 on 7/2/24.
//

import UIKit
import SnapKit

class ListTableViewCell: BaseTableViewCell {
    
    let checkButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.tintColor = UIColor.lightGray
        
        return button
    }()
    
    let todoTitle: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    let todoMemo: UILabel = {
        let label = UILabel()
        
        label.text = "키캡 알아보기"
        label.textColor = UIColor.systemGray3
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    let todoDoneDate: UILabel = {
        let label = UILabel()
        
        label.text = "2024.02.02"
        label.textColor = UIColor.systemGray3
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(checkButton)
        contentView.addSubview(todoTitle)
        contentView.addSubview(todoMemo)
        contentView.addSubview(todoDoneDate)
    }
    
    override func configureLayout() {
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(15)
            make.width.height.equalTo(25)
        }
        
        todoTitle.snp.makeConstraints { make in
            make.top.equalTo(checkButton.snp.top)
            make.leading.equalTo(checkButton.snp.trailing).offset(15)
            make.height.equalTo(checkButton.snp.height)
        }
        
        todoMemo.snp.makeConstraints { make in
            make.top.equalTo(todoTitle.snp.bottom).offset(5)
            make.leading.equalTo(todoTitle)
            make.height.equalTo(13)
        }
        
        todoDoneDate.snp.makeConstraints { make in
            make.top.equalTo(todoMemo.snp.bottom).offset(10)
            make.leading.equalTo(todoTitle)
            make.height.equalTo(13)
        }
        
    }
    
    override func configureView() {
        contentView.backgroundColor = UIColor.black
        
        
    }
    
}
