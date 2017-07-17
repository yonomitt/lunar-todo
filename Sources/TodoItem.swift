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
    
    func jsonDict() -> JSONDict {
        return ["id": id,
                "title": title]
    }
}
