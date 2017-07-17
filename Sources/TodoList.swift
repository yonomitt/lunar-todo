//
//  TodoList.swift
//  todo-moonshot
//
//  Created by Yonatan Mittlefehldt on 2017-07-17.
//
//

struct TodoList {
    
    private var items = [TodoItem]()
    
    mutating func add(item: TodoItem) {
        items.append(item)
    }
    
    func jsonArray() -> [JSONDict] {
        return items.map { $0.jsonDict() }
    }
}
