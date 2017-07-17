//
//  TodoItem.swift
//  todo-moonshot
//
//  Created by Yonatan Mittlefehldt on 2017-07-17.
//
//

struct TodoItem {
    
    var id = -1
    var title = ""
    var completed = false
    var order = -1
    
    var url: String {
        return "\(URLBASE)/\(id)/"
    }
    
    init() {
        
    }
    
    init(id: Int, json: JSONDict) {
        self.id = id
        title = json["title"] as? String ?? ""
        completed = json["completed"] as? Bool ?? false
        order = json["order"] as? Int ?? -1
    }
    
    func jsonDict() -> JSONDict {
        return ["title": title,
                "completed": completed,
                "order": order,
                "url": url]
    }
}
