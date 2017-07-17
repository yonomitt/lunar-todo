//
//  TodoList.swift
//  todo-moonshot
//
//  Created by Yonatan Mittlefehldt on 2017-07-17.
//
//

import Rope

struct TodoList {
    
    private var nextID = 0
    private var items = [TodoItem]()
    
    var db: Rope?
    
    mutating func add(item: TodoItem) -> TodoItem {
        
        var newItem = item
            
        newItem.id = nextID
        nextID += 1
        
        items.append(newItem)
        
        return newItem
    }
    
    mutating func delete(for id: Int) {
        
        if let index = items.index(where: { $0.id == id }) {
            items.remove(at: index)
        }
    }
    
    mutating func clear() {
        items.removeAll()
    }
    
    func findItem(for id: Int) -> TodoItem? {
        
        if let index = items.index(where: { $0.id == id }) {
            return items[index]
        }
        
        return nil
    }
    
    mutating func updateTitle(for id: Int, title: String) -> TodoItem? {
        
        if let index = items.index(where: { $0.id == id }) {
            items[index].title = title
            
            return items[index]
        }
        
        return nil
    }
    
    mutating func updateCompleted(for id: Int, completed: Bool) -> TodoItem? {
        
        if let index = items.index(where: { $0.id == id }) {
            items[index].completed = completed
            
            return items[index]
        }
        
        return nil
    }
    
    mutating func updateOrder(for id: Int, order: Int) -> TodoItem? {
        
        if let index = items.index(where: { $0.id == id }) {
            items[index].order = order
            
            return items[index]
        }
        
        return nil
    }
    
    func jsonArray() -> [JSONDict] {
        return items.map { $0.jsonDict() }
    }
}
