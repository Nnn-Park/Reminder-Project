//
//  RegisterViewController.swift
//  Reminder
//
//  Created by 박재형 on 7/2/24.
//

import UIKit
import SnapKit
import RealmSwift

final class RegisterViewController: BaseViewController {
    
    enum registerTitle: String, CaseIterable {
        case doneDate = "마감일"
        case tag = "태그"
        case rank = "우선 순위"
        case appendImage = "이미지 추가"
    }
    
    let tableView = UITableView()
    
    let memoView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.systemGray3
        
        return view
    }()
    
    let todoTitleTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "제목"
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.textColor = .label
        
        return textField
    }()
    
    let todoMemoTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "메모"
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.textColor = .label
        
        return textField
    }()
    
    let todoFinishTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "마감일"
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.textColor = .label
        
        return textField
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    override func configureHierarchy() {
        view.addSubview(memoView)
        view.addSubview(tableView)
        view.addSubview(todoTitleTextField)
        view.addSubview(todoMemoTextField)
        view.addSubview(todoFinishTextField)
        view.addSubview(separatorView)
    }
    
    override func configureConstraints() {
        memoView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(200)
        }
        
        todoTitleTextField.snp.makeConstraints { make in
            make.top.equalTo(memoView.snp.top).offset(15)
            make.leading.equalTo(memoView.snp.leading).offset(15)
            make.trailing.equalTo(memoView.snp.trailing).offset(-15)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(todoTitleTextField.snp.bottom).offset(10)
            make.leading.equalTo(todoTitleTextField)
            make.trailing.equalTo(todoTitleTextField)
            make.height.equalTo(1)
        }
        
        todoMemoTextField.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(5)
            make.leading.equalTo(todoTitleTextField)
            make.trailing.equalTo(todoTitleTextField)
            make.height.equalTo(60)
        }
        
        todoFinishTextField.snp.makeConstraints { make in
            make.top.equalTo(todoMemoTextField.snp.bottom).offset(35)
            make.leading.equalTo(todoTitleTextField)
            make.trailing.equalTo(todoTitleTextField)
            make.height.equalTo(25)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(memoView.snp.bottom).offset(20)
            make.leading.equalTo(memoView.snp.leading)
            make.trailing.equalTo(memoView.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    override func configureView() {
        view.backgroundColor = UIColor.white
        
        //        todoTableView.rowHeight = UITableView.automaticDimension
        //        todoTableView.estimatedRowHeight = 100
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RegisterTodoTableViewCell.self, forCellReuseIdentifier: RegisterTodoTableViewCell.id)
        
        navigationItem.title = "새로운 할 일"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancleButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonClicked))
        
        memoView.layer.cornerRadius = 10
    }
    
    @objc func cancleButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addButtonClicked() {
        let realm = try! Realm()
        
        guard let title = todoTitleTextField.text, !title.isEmpty,
              let memo = todoMemoTextField.text,
              let finishDate = todoFinishTextField.text else {
            showAlert(title: "제목을 입력해주세요", message: "")
            return
        }
        
        let data = TodoTable(todoTitle: title, todoMemo: memo, todoDoneDate: finishDate, todoHashTag: nil)
        
        try! realm.write {
            realm.add(data)
            print("Realm Create Succeed")
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registerTitle.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RegisterTodoTableViewCell.id, for: indexPath) as! RegisterTodoTableViewCell
        let registerTitle = registerTitle.allCases[indexPath.row]
        cell.configureTitle(title: registerTitle.rawValue)
        
        return cell
    }
    
}
