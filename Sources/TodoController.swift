import Foundation
import Titan
import TitanCORS


/// The main controller to handle all the Todo app routes
final class TodoController {

    let app: Titan
    
    init(app: Titan) {
        self.app = app
        
        self.app.get("/", handleWebroot)
        
        // POST a todo item
        self.app.post("/", handlePostTodo)
        
        addInsecureCORSSupport(self.app)
    }
    
    /// This function will handle the GET requests at the root page
    
    func handleWebroot(req: RequestType, res: ResponseType) -> (RequestType, ResponseType) {
        return (req, Response(200, "This is a simple Todo-Backend implementation using Swift, Titan, Kitura, and Postgres"))
    }
    
    /// This function handles the todo POST requests
    
    func handlePostTodo(req: RequestType, res: ResponseType) -> (RequestType, ResponseType) {
        
        guard let json = req.json as? JSONDict else {
            return (req, Response(400))
        }
            
        return (req, Response(200, String.from(json)))
    }
}
