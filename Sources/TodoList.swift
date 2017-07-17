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
    
    mutating func clear() {
        items.removeAll()
    }
    
    func jsonArray() -> [JSONDict] {
        return items.map { $0.jsonDict() }
    }
}
