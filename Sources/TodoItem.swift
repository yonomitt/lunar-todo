//
//  TodoItem.swift
//  todo-moonshot
//
//  Created by Yonatan Mittlefehldt on 2017-07-17.
//
//

struct TodoItem {
    
    var id = -1 {
        didSet {
            url = "/\(id)/"
        }
    }
    
    var title = ""
    var completed = false
    var url = ""
    
    func jsonDict() -> JSONDict {
        return ["title": title,
                "completed": completed,
                "url": url]
    }
}
