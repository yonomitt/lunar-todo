import Titan
import TitanKituraAdapter

let app = Titan()

/// Hello World, req is sent to next matching route 
app.get("/") { req, _ in
    return (req, Response(200, "Hello World"))
}

// start the Kitura webserver on port 8088
TitanKituraAdapter.serve(app.app, on: 8088)

