import Foundation
import Titan
import TitanCORS


/// The main controller to handle all the Todo app routes
final class TodoController {

    let app: Titan
    
    var todoList = TodoList()
    
    init(app: Titan) {
        self.app = app
        
        // GET all todo items
        self.app.get("/", handleWebroot)
        
        // GET a single todo item
        self.app.get("/*", handleGetItem)
        
        // POST a todo item
        self.app.post("/", handlePostTodo)
        
        // PATCH a todo item
        self.app.patch("/*", handlePatchTodo)
        
        // DELETE all todo items
        self.app.delete("/", handleDelete)
        
        // DELETE a single todo item
        self.app.delete("/*", handleDeleteItem)
        
        addInsecureCORSSupport(self.app)
    }
    
    /// This function will handle the GET requests at the root page
    
    func handleWebroot(req: RequestType, res: ResponseType) -> (RequestType, ResponseType) {
        
        return (req, Response(200, String.from(todoList.jsonArray())))
    }
    
    /// This function will handle GET requests for a particular todo url
    
    func handleGetItem(req: RequestType, id: String, res: ResponseType) -> (RequestType, ResponseType) {
        
        if let id = Int(id),
            let item = todoList.findItem(for: id) {
            
            return (req, Response(200, String.from(item.jsonDict())))
        }

        return (req, Response(400))
    }
    
    /// This function handles the todo POST requests
    
    func handlePostTodo(req: RequestType, res: ResponseType) -> (RequestType, ResponseType) {
        
        guard let json = req.json as? JSONDict else {
            return (req, Response(400))
        }
        
        var todoItem = TodoItem()
        todoItem.title = json["title"] as? String ?? ""
        
        todoItem = todoList.add(item: todoItem)
        
        return (req, Response(200, String.from(todoItem.jsonDict())))
    }
    
    /// This function handles the todo PATCH requests
    
    func handlePatchTodo(req: RequestType, id: String, res: ResponseType) -> (RequestType, ResponseType) {
        
        if let json = req.json as? JSONDict,
            let id = Int(id) {
            
            var item: TodoItem? = nil
            
            if let title = json["title"] as? String {
                item = todoList.updateTitle(for: id, title: title)
            }
            
            if let completed = json["completed"] as? Bool {
                item = todoList.updateCompleted(for: id, completed: completed)
            }
            
            if let item = item {
                return (req, Response(200, String.from(item.jsonDict())))
            }
        }
        
        return (req, Response(400))
    }
    
    /// This function handles the todo DELETE requests
    
    func handleDelete(req: RequestType, res: ResponseType) -> (RequestType, ResponseType) {
        
        todoList.clear()
        
        return (req, Response(200))
    }
    
    /// This function will handle GET requests for a particular todo url
    
    func handleDeleteItem(req: RequestType, id: String, res: ResponseType) -> (RequestType, ResponseType) {
        
        if let id = Int(id) {
            todoList.delete(for: id)
        }
        
        return (req, Response(200))
    }
}
