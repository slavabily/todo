//
//  ContentView.swift
//  todo_UI
//
//  Created by slava bily on 14.10.2020.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var ns = NetworkService()
    
    @State var todoItem: String
    @State private var selectedPriority = 0
    
    var priorities = ["Low", "Medium", "High"]
    
    var body: some View {
        VStack {
            Text("todo UI")
                .font(.headline)
                .padding()
              
            TextField("Enter Todo Item", text: $todoItem, onCommit:  {
                addTodo()
            })
            .padding()
            
            Picker("", selection: $selectedPriority) {
                ForEach(0..<priorities.count) {
                    Text(priorities[$0])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            List {  
                ForEach(0..<ns.todos.items.count, id: \.self) {
                    TodoCell(item: ns.todos.items[$0].item,
                             priority: ns.todos.items[$0].priority
                    )
                }       
            }
            .onAppear {
                getTodos()
            }
        } 
    }
    
    func getTodos() {
        NetworkService.shared.getTodos { (todos) in
            print(todos.items)
            self.ns.todos.items = todos.items
        } onError: { (errorMessage) in
            //show error to user
            debugPrint(errorMessage)
        }
    }
    
    func addTodo() {
        
        guard todoItem != "" else {
            //show error " you must enter todo item"
            return
        }
        
        let todo = Todo(id: nil, item: todoItem, priority: selectedPriority, index: nil)
        
        NetworkService.shared.addTodo(todo: todo) { (todos) in
            todoItem = ""
            ns.todos.items = todos.items
        } onError: { (errorMessage) in
            //show any errors to user on POST
            debugPrint(errorMessage)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView(todoItem: "Clean the house")
    }
}

