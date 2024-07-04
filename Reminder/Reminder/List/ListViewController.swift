//
//  ListViewController.swift
//  Reminder
//
//  Created by 박재형 on 7/2/24.
//

import UIKit
import SnapKit
import RealmSwift

final class ListViewController: BaseViewController {
    
    let tableView = UITableView()
    
    var list: Results<TodoTable>!
    
    let realm = try! Realm()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "전체" // 추후에 메인화면 카테고리 제목으로 변경
        label.textColor = UIColor.systemBlue
        label.font = UIFont.boldSystemFont(ofSize: 35)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        list = realm.objects(TodoTable.self)
    }
    
    @objc func backButtonClicked() {
        print(#function)
//        print(realm.configuration.fileURL)
    }
    
    @objc func addButtonClicked() {
        let registerVC = RegisterViewController()
        
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @objc func filterButtonClicked() {
        print(#function)
        let actionSheet = UIAlertController(title: "필터링", message: "필요한 필터를 선택하세요", preferredStyle: .actionSheet)
        
        let sortDate = UIAlertAction(title: "마감일 순으로 보기", style: .default) { _ in
            self.list = self.list.sorted(byKeyPath: "todoDoneDate", ascending: true)
            self.tableView.reloadData()
        }
        
        let sortTitle = UIAlertAction(title: "제목 순으로 보기", style: .default) { _ in
            self.list = self.list.sorted(byKeyPath: "todoTitle", ascending: true)
            self.tableView.reloadData()
        }
        
        let sortRank = UIAlertAction(title: "우선 순위 낮음만 보기", style: .default) { _ in
            // 나중 구현
        }
        
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        actionSheet.addAction(sortDate)
        actionSheet.addAction(sortTitle)
        actionSheet.addAction(sortRank)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
        view.addSubview(categoryLabel)
    }
    
    override func configureConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(30)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func configureView() {
        tableView.backgroundColor = UIColor.black
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.id)
        let addTodoButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonClicked))
        let filterButton = UIBarButtonItem(title: "", image: UIImage(systemName: "ellipsis.circle"), target: self, action: #selector(filterButtonClicked))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", image: UIImage(systemName: "chevron.backward"), target: self, action: #selector(backButtonClicked))
        navigationItem.rightBarButtonItems = [addTodoButton, filterButton]
    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id, for: indexPath) as! ListTableViewCell
        
        let data = list[indexPath.row]
        
        cell.todoTitle.text = data.todoTitle
        cell.todoMemo.text = data.todoMemo
        cell.todoDoneDate.text = data.todoDoneDate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { action, view, completionHandler in
            
            let todoDelete = self.list[indexPath.row]
            
            try! self.realm.write {
                self.realm.delete(todoDelete)
            }
            
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}
