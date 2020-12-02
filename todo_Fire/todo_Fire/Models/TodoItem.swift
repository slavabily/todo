//
//  TodoItem.swift
//  todo_Fire
//
//  Created by slava bily on 30.11.2020.
//

import Foundation
import Firebase

struct TodoItem: Hashable {
    let ref: DatabaseReference?
    let key: String
    let name: String
    
    init(name: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.name = name
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String
        else   {return nil }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.name = name     
    }
    
    func toAnyObject() -> Any {
        return [
            "name:": name
        ]
    }
}
