//
//  TodoItem.swift
//  todo-moonshot
//
//  Created by Yonatan Mittlefehldt on 2017-07-17.
//
//

struct TodoItem {
    
    var title = ""
    
    func jsonDict() -> JSONDict {
        return ["title": title]
    }
}
