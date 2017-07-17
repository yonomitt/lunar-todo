import Foundation
import Rope
import Titan
import TitanCORS


/// The main controller to handle all the Todo app routes
final class TodoController {

    let app: Titan
    
    var todoList = TodoList()
    
    init(app: Titan, db: Rope?) {
        todoList.db = db
        self.app = app
        
        self.app.get("/", getAllTodoItems)
        
        self.app.get("/*", getOneTodoItem)
        
        self.app.post("/", createTodoItem)
        
        self.app.patch("/*", editTodoItem)
        
        self.app.delete("/", deleteAllTodoItems)
        
        self.app.delete("/*", deleteOneTodoItem)
        
        addInsecureCORSSupport(self.app)
    }
}

// MARK: Handler functions

extension TodoController {

    /// GET request at the API root to retrieve all todo items
    func getAllTodoItems(req: RequestType, res: ResponseType) -> (RequestType, ResponseType) {
        
        return (req, Response(200, String.from(todoList.jsonArray())))
    }
    
    /// GET request for single todo item based on ID string
    func getOneTodoItem(req: RequestType, id: String, res: ResponseType) -> (RequestType, ResponseType) {
        
        if let id = Int(id),
            let item = todoList.findItem(for: id) {
            
            return (req, Response(200, String.from(item.jsonDict())))
        }
        
        return (req, Response(400))
    }
    
    /// POST request to create a single todo item
    func createTodoItem(req: RequestType, res: ResponseType) -> (RequestType, ResponseType) {
        
        guard let json = req.json as? JSONDict else {
            return (req, Response(400))
        }
        
        var todoItem = TodoItem()
        todoItem.title = json["title"] as? String ?? ""
        todoItem.order = json["order"] as? Int ?? -1
        
        todoItem = todoList.add(item: todoItem)
        
        return (req, Response(200, String.from(todoItem.jsonDict())))
    }
    
    /// PATCH request to edit todo items -- title, completed, and order can be changed
    func editTodoItem(req: RequestType, id: String, res: ResponseType) -> (RequestType, ResponseType) {
        
        if let json = req.json as? JSONDict,
            let id = Int(id) {
            
            var item: TodoItem? = nil
            
            if let title = json["title"] as? String {
                item = todoList.updateTitle(for: id, title: title)
            }
            
            if let completed = json["completed"] as? Bool {
                item = todoList.updateCompleted(for: id, completed: completed)
            }
            
            if let order = json["order"] as? Int {
                item = todoList.updateOrder(for: id, order: order)
            }
            
            if let item = item {
                return (req, Response(200, String.from(item.jsonDict())))
            }
        }
        
        return (req, Response(400))
    }
    
    /// DELETE request at the API root to delete all todo items
    func deleteAllTodoItems(req: RequestType, res: ResponseType) -> (RequestType, ResponseType) {
        
        todoList.clear()
        
        return (req, Response(200))
    }
    
    /// DELETE request for single todo item based on ID string
    func deleteOneTodoItem(req: RequestType, id: String, res: ResponseType) -> (RequestType, ResponseType) {
        
        if let id = Int(id) {
            todoList.delete(for: id)
        }
        
        return (req, Response(200))
    }
}
