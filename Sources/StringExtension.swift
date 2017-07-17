//
//  StringExtension.swift
//  todo-moonshot
//
//  Created by Yonatan Mittlefehldt on 2017-07-17.
//
//

import Foundation

extension String {
    
    static func from(_ json: JSONDict) -> String {
        
        if let data = try? JSONSerialization.data(withJSONObject: json, options: []) {

            let string = String(data: data, encoding: .utf8) ?? "{}"
            
            return string
            
        }
        
        return "{}"
    }
    
    static func from(_ json: [JSONDict]) -> String {
        
        if let data = try? JSONSerialization.data(withJSONObject: json, options: []) {
            
            let string = String(data: data, encoding: .utf8) ?? "[]"
            
            return string
            
        }
        
        return "[]"
    }
}
