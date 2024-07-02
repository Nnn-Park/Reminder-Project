//
//  RegisterTodoTableViewCell.swift
//  Reminder
//
//  Created by 박재형 on 7/2/24.
//

import UIKit
import SnapKit

final class RegisterTodoTableViewCell: BaseTableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .label
        
        return label
    }()
    
    let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .gray
        
        return imageView
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowImageView)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(15)
            make.centerY.equalTo(contentView)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).offset(-15)
            make.centerY.equalTo(contentView)
        }
    }
    
    override func configureView() {
        contentView.backgroundColor = UIColor.systemGray3
    }
    
    func configureTitle(title: String) {
        titleLabel.text = title
        titleLabel.textColor = UIColor.black 
    }
    
}
