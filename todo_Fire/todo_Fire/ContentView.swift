//
//  ContentView.swift
//  todo_Fire
//
//  Created by slava bily on 30.11.2020.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    let ref = Database.database().reference(withPath: "todo-items")
    
    @EnvironmentObject var todoItems: TodoItems
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(todoItems.items, id: \.self) { todo in
                    
                    HStack {
                        Text("\(todo.name)")
                            
                            .frame(width: 300, alignment: .leading)
                             
//                        PriorityView(priority: Int(todo.priority))
                    }
                }
//                .onDelete(perform: deleteTodos(at:))
            }
            .onAppear {
                loadItems()
            }
            .navigationBarTitle(Text("todoFire"))
            .navigationBarItems(trailing: Button(action: {
                showingAddScreen.toggle()
            }, label: {
                Image(systemName: "plus.circle")
                    .scaleEffect(1.5)
            }))
//            .sheet(isPresented: $showingAddScreen) {
//                AddTodoView(todos: todos).environment(\.managedObjectContext, moc)
//            }
        }
    }
    
    func loadItems() {
        ref.observe(.value) { (snapshot) in
            var newItems = [TodoItem]()
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot, let todoItem = TodoItem(snapshot: snapshot) {
                    newItems.append(todoItem)
                }
            }
            todoItems.items = newItems
        }
    }
    
 
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
