//
//  StringExtension.swift
//  todo-moonshot
//
//  Created by Yonatan Mittlefehldt on 2017-07-17.
//
//

import Foundation

extension String {
    
    /// Convert a JSON dictionary to a string
    ///
    /// - Parameter json: a JSON dictionary
    /// - Returns: a string representation
    static func from(_ json: JSONDict) -> String {
        
        if let data = try? JSONSerialization.data(withJSONObject: json, options: []) {

            let string = String(data: data, encoding: .utf8) ?? "{}"
            
            return string
            
        }
        
        return "{}"
    }
    
    /// Convert an array of JSON dictionaries to a string
    ///
    /// - Parameter json: an array of JSON dictionaries
    /// - Returns: a string representation
    static func from(_ json: [JSONDict]) -> String {
        
        if let data = try? JSONSerialization.data(withJSONObject: json, options: []) {
            
            let string = String(data: data, encoding: .utf8) ?? "[]"
            
            return string
            
        }
        
        return "[]"
    }
}
