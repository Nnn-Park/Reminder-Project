//
//  RealmModel.swift
//  Reminder
//
//  Created by 박재형 on 7/2/24.
//

import Foundation
import RealmSwift

class TodoTable: Object {
    
    @Persisted var todoTitle: String
    @Persisted var todoMemo: String
    @Persisted var todoDoneDate: String
    @Persisted var todoHashTag: String? // 태그는 추후에 추가하기 -> 마이그레이션
    
    convenience init(todoTitle: String, todoMemo: String, todoDoneDate: String, todoHashTag: String?) {
        self.init()
        self.todoTitle = todoTitle
        self.todoMemo = todoMemo
        self.todoDoneDate = todoDoneDate
        self.todoHashTag = todoHashTag
    }
    
}
