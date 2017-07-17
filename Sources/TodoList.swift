//
//  TodoList.swift
//  todo-moonshot
//
//  Created by Yonatan Mittlefehldt on 2017-07-17.
//
//

struct TodoList {
    
    private var items = [TodoItem]()
    
    func jsonArray() -> [JSONDict] {
        return items.map { $0.jsonDict() }
    }
}
