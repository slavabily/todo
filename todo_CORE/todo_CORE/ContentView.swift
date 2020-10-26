//
//  ContentView.swift
//  todo_CORE
//
//  Created by slava bily on 24.10.2020.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext)
    var moc
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [])
    var todos: FetchedResults<Todo>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(todos, id: \.self) { todo in
                    Text("\(todo.item ?? "")")
                        .padding()
                    
                }
            }
            .navigationBarTitle(Text("todoREST"))
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                showingAddScreen.toggle()
            }, label: {
                Image(systemName: "plus.circle")
            }))
            .sheet(isPresented: $showingAddScreen) {
                AddItemView().environment(\.managedObjectContext, moc)
            }
        }  
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
