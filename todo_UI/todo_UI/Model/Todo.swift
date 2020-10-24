//
//  Todo.swift
//  todo
//
//  Created by slava bily on 05.10.2020.
//

import Foundation

struct  Todos: Codable {
    var items: Array<Todo>
}

struct Todo: Codable, Equatable {
    let id: UUID?
    
    let item: String
    let priority: Int
    var index: Int?
}
