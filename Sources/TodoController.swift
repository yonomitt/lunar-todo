import Foundation
import Titan
import TitanCORS


/// The main controller to handle all the Todo app routes
final class TodoController {

    let app: Titan
    
    init(app: Titan) {
        self.app = app
        
        self.app.get("/", handleWebroot)
        
        addInsecureCORSSupport(self.app)
    }
    
    /// This function will handle the GET requests at the root page
    
    func handleWebroot(req: RequestType, res: ResponseType) -> (RequestType, ResponseType) {
        return (req, Response(200, "This is a simple Todo-Backend implementation using Swift, Titan, Kitura, and Postgres"))
    }
}
