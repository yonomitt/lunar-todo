import Foundation
import Titan
import TitanKituraAdapter

let env = ProcessInfo.processInfo.environment
let URLBASE = env["SERVER_HOST"] ?? ""

let todoController = TodoController(app: Titan())

// start the Kitura webserver on port 8088
TitanKituraAdapter.serve(todoController.app.app, on: 8088)

