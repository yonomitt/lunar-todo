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
    
    var db: Rope? {
        didSet {
            let _ = try? db?.query("CREATE TABLE IF NOT EXISTS todo ( id SERIAL PRIMARY KEY, item JSONB )")
        }
    }
    
    mutating func add(item: TodoItem) -> TodoItem {
        
        var newItem = item
        
        if let db = db {
            
            let res = try? db.query("INSERT INTO todo (item) VALUES($1) RETURNING id", params: [String.from(item.jsonDict())])
            if let row = res?.rows().first {
                newItem.id = row["id"] as? Int ?? newItem.id
            }
        } else {
            
            newItem.id = nextID
            nextID += 1

            items.append(newItem)
        }
        
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
    
    mutating func jsonArray() -> [JSONDict] {
        
        if let db = db {
        
            let res = try? db.query("SELECT id, item FROM todo")
            if let rows = res?.rows() {
                items.removeAll()
                for row in rows {
                    let id = row["id"] as? Int ?? -1
                    let item = row["item"] as? JSONDict ?? [:]
                    let todoItem = TodoItem(id: id, json: item)
                    items.append(todoItem)
                }
            }
        }
        
        return items.map { $0.jsonDict() }
    }
}
