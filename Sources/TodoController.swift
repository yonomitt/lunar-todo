import Foundation
import Titan
import TitanCORS


/// The main controller to handle all the Todo app routes
final class TodoController {

    let app: Titan
    
    var todoList = TodoList()
    
    init(app: Titan) {
        self.app = app
        
        self.app.get("/", handleWebroot)
        
        // POST a todo item
        self.app.post("/", handlePostTodo)
        
        // DELETE a todo item
        self.app.delete("/", handleDelete)
        
        addInsecureCORSSupport(self.app)
    }
    
    /// This function will handle the GET requests at the root page
    
    func handleWebroot(req: RequestType, res: ResponseType) -> (RequestType, ResponseType) {
        
        return (req, Response(200, String.from(todoList.jsonArray())))
    }
    
    /// This function handles the todo POST requests
    
    func handlePostTodo(req: RequestType, res: ResponseType) -> (RequestType, ResponseType) {
        
        guard let json = req.json as? JSONDict else {
            return (req, Response(400))
        }
        
        let todoItem = TodoItem(title: json["title"] as? String ?? "")
        todoList.add(item: todoItem)
        
        return (req, Response(200, String.from(json)))
    }
    
    /// This function handles the todo DELETE requests
    
    func handleDelete(req: RequestType, res: ResponseType) -> (RequestType, ResponseType) {
        
        return (req, Response(200))
    }
}
