//
//  Todo_r.swift
//  todo_CR
//
//  Created by slava bily on 03.11.2020.
//

import Foundation

struct  Todos_r: Codable {
    var items: Array<Todo_r>
}

struct Todo_r: Codable, Equatable {
    let id: UUID?
    
    let item: String
    let priority: Int
    var index: Int?
}
