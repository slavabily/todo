//
//  ContentView.swift
//  todo_CR
//
//  Created by slava bily on 02.11.2020.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext)
    var moc
    
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [])
    var todos: FetchedResults<Todo>
    
    @State private var showingAddScreen = false
    
    // For REST API
    
    @ObservedObject var ns = NetworkService()
    
    @State private var isServerAvailable = false
    
    var body: some View {
        NavigationView {
            List {
                if isServerAvailable {
                    ForEach(0..<ns.todos.items.count, id: \.self) {
                        TodoCell(item: ns.todos.items[$0].item,
                                 priority: ns.todos.items[$0].priority
                        )
                    }
//                    .onDelete(perform: deleteTodo)
                } else {
                    ForEach(todos, id: \.self) { todo in
                        
                        HStack {
                            Text("\(todo.item ?? "")")
                                
                                .frame(width: 300, alignment: .leading)
                                 
                            PriorityView(priority: Int(todo.priority))
                        }
                    }
                    .onDelete(perform: deleteTodos(at:))
                }
            }
            .onAppear {
                getTodos()
            }
            .navigationBarTitle(Text("todo_CR"))
            .navigationBarItems(trailing: Button(action: {
                showingAddScreen.toggle()
            }, label: {
                Image(systemName: "plus.circle")
                    .scaleEffect(1.5)
            }))
            .sheet(isPresented: $showingAddScreen) {
                AddTodoView(todos: todos).environment(\.managedObjectContext, moc)
            }
        }
    }
    
    func getTodos() {
        NetworkService.shared.getTodos { (todos) in
            
            isServerAvailable.toggle()
            
            print(todos.items)
            self.ns.todos.items = todos.items
        } onError: { (errorMessage) in
            //show error to user
            debugPrint(errorMessage)
        }
    }
    
    // CoreData deletion
    func deleteTodos(at offsets: IndexSet) {
        for offset in offsets {
            let todo = todos[offset]
            moc.delete(todo)
        }
        try? moc.save()
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
