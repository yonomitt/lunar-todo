//
//  TodoList.swift
//  todo-moonshot
//
//  Created by Yonatan Mittlefehldt on 2017-07-17.
//
//

struct TodoList {
    
    private var nextID = 0
    private var items = [TodoItem]()
    
    mutating func add(item: TodoItem) -> TodoItem {
        
        var newItem = item
            
        newItem.id = nextID
        nextID += 1
        
        items.append(newItem)
        
        return newItem
    }
    
    mutating func clear() {
        items.removeAll()
    }
    
    func jsonArray() -> [JSONDict] {
        return items.map { $0.jsonDict() }
    }
}
