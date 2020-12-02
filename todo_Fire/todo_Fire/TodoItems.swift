//
//  TodoItems.swift
//  todo_Fire
//
//  Created by slava bily on 30.11.2020.
//

import Foundation
import Combine

class TodoItems: ObservableObject {
    @Published var items = [TodoItem]()
}
