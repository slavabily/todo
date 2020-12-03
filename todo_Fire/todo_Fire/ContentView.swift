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
                             
                        PriorityView(priority: Int(todo.priority))
                    }
                }
                .onDelete(perform: deleteItems(at:))
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
            .sheet(isPresented: $showingAddScreen) {
                AddTodoView().environmentObject(todoItems)
            }
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        for offset in offsets {
            let todoItem = todoItems.items[offset]
            todoItem.ref?.removeValue()
        }
    }
    
    func loadItems() {
        ref.queryOrdered(byChild: "priority").observe(.value) { (snapshot) in
            print(snapshot.value as Any)
            var newItems: [TodoItem] = []

            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot, let todoItem = TodoItem(snapshot: snapshot) {
                    newItems.append(todoItem)
                } else {
                    print("Something goes wrong...")
                }
            }
            todoItems.items = newItems
            print(todoItems.items)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
