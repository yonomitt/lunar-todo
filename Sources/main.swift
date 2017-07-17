import Foundation
import Titan
import TitanKituraAdapter

let todoController = TodoController(app: Titan())

// start the Kitura webserver on port 8088
TitanKituraAdapter.serve(todoController.app.app, on: 8088)

