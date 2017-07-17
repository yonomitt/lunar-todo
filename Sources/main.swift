import Foundation
import Rope
import Titan
import TitanKituraAdapter


let env = ProcessInfo.processInfo.environment
let URLBASE = env["SERVER_HOST"] ?? ""

let dbHost = env["POSTGRES_HOST"] ?? ""
let dbUser = env["POSTGRES_USER"] ?? ""
let dbPassword = env["POSTGRES_PASSWORD"] ?? ""
let dbName = env["POSTGRES_DB"] ?? ""

let dbCredentials = RopeCredentials(host: dbHost, port: 5432,  dbName: dbName, user: dbUser, password: dbPassword)
let db = try? Rope.connect(credentials: dbCredentials)

let todoController = TodoController(app: Titan())

// start the Kitura webserver on port 8088
TitanKituraAdapter.serve(todoController.app.app, on: 8088)

