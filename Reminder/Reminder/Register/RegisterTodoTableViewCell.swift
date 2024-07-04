//
//  RegisterTodoTableViewCell.swift
//  Reminder
//
//  Created by 박재형 on 7/2/24.
//

import UIKit
import SnapKit

final class RegisterTodoTableViewCell: BaseTableViewCell {
    
    let cellView: UIView = {
        let  view = UIView()
        
        view.backgroundColor = UIColor.black
        
        return view
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.gray
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        
        return label
    }()
    
    let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = UIColor.white
        
        return imageView
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(cellView)
        contentView.addSubview(separatorView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowImageView)
    }
    
    override func configureLayout() {
        
        cellView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(cellView.snp.top).offset(15)
            make.leading.trailing.equalTo(contentView)
            make.height.equalTo(50)
        }
        
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
        contentView.layer.cornerRadius = 10
    }
    
    func configureTitle(title: String) {
        titleLabel.text = title

    }
    
}
