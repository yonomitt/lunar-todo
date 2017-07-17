//
//  TodoList.swift
//  todo-moonshot
//
//  Created by Yonatan Mittlefehldt on 2017-07-17.
//
//

import Rope

struct TodoList {
    
    var db: Rope? {
        didSet {
            // Create the table (if it doesn't exist) when the db property is set to ensure it is ready for use
            let _ = try? db?.query("CREATE TABLE IF NOT EXISTS todo ( id SERIAL PRIMARY KEY, item JSONB )")
        }
    }
    
    var useDatabase: Bool {
        return db != nil
    }
    
    // In memory storage to fall back to if there is a problem with the database
    private var nextID = 0
    private var items = [TodoItem]()
    
    
    /// Add a todo item to the list
    ///
    /// - Parameter item: todo item to add
    /// - Returns: the added todo item with a generated ID
    mutating func add(item: TodoItem) -> TodoItem {
        
        var newItem = item
        
        if useDatabase {
            
            // Insert the item into the database and return the ID that was generated
            let res = try? db!.query("INSERT INTO todo (item) VALUES($1) RETURNING id", params: [String.from(item.jsonDict())])
            if let row = res?.rows().first {
                newItem.id = row["id"] as? Int ?? newItem.id
            }
            
        } else {
            
            // Manual ID creation
            newItem.id = nextID
            nextID += 1

            items.append(newItem)
        }
        
        return newItem
    }
    
    /// Delete a todo item
    ///
    /// - Parameter id: ID of the todo item to delete
    mutating func delete(for id: Int) {
        
        if useDatabase {
            let _ = try? db?.query("DELETE FROM todo WHERE id=$1", params: [id])
        } else {
            if let index = items.index(where: { $0.id == id }) {
                items.remove(at: index)
            }
        }
    }
    
    /// Clear the todo list
    mutating func clear() {
        
        if useDatabase {
            let _ = try? db?.query("DELETE FROM todo")
        } else {
            items.removeAll()
        }
    }
    
    /// Find a todo item by its ID
    ///
    /// - Parameter id: ID of the todo item to find
    /// - Returns: the found todo item or nil if not found
    func findItem(for id: Int) -> TodoItem? {
        
        if useDatabase {
            
            let res = try? db!.query("SELECT id, item FROM todo WHERE id=$1", params: [id])
            
            if let row = res?.rows().first {
                let id = row["id"] as? Int ?? -1
                let item = row["item"] as? JSONDict ?? [:]
                let todoItem = TodoItem(id: id, json: item)
                
                return todoItem
            }
        } else {
            
            if let index = items.index(where: { $0.id == id }) {
                return items[index]
            }
        }
        
        return nil
    }
    
    /// Update a todo item
    ///
    /// - Parameters:
    ///   - id: ID of the todo item to update
    ///   - title: new title (or nil if the old one should be kept)
    ///   - completed: new completed status (or nil if the old one should be kept)
    ///   - order: new order number (or nil if the old one should be kept)
    /// - Returns: the updated todo item or nil if not found
    mutating func updateItem(for id: Int, title: String?, completed: Bool?, order: Int?) -> TodoItem? {
    
        if useDatabase {
            
            if let item = findItem(for: id) {
                
                var updated = item
                
                updated.title = title ?? item.title
                updated.completed = completed ?? item.completed
                updated.order = order ?? item.order
                
                let _ = try? db?.query("UPDATE todo SET item=$1 WHERE id=$2", params: [String.from(updated.jsonDict()), id])
                
                return updated
            }

        } else {
            
            if let index = items.index(where: { $0.id == id }) {
                
                items[index].title = title ?? items[index].title
                items[index].completed = completed ?? items[index].completed
                items[index].order = order ?? items[index].order
                
                return items[index]
            }
        }
        
        return nil
    }
    
    /// Represents the todo list as a JSON array object
    ///
    /// - Returns: an array of JSON dictionaries representing the todo list
    func jsonArray() -> [JSONDict] {
        
        var allItems: [TodoItem]

        if useDatabase {
        
            allItems = [TodoItem]()
            
            let res = try? db!.query("SELECT id, item FROM todo")

            if let rows = res?.rows() {
                for row in rows {
                    let id = row["id"] as? Int ?? -1
                    let item = row["item"] as? JSONDict ?? [:]
                    let todoItem = TodoItem(id: id, json: item)
                    allItems.append(todoItem)
                }
            }
            
        } else {
            allItems = items
        }
        
        return allItems.map { $0.jsonDict() }
    }
}
