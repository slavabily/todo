//
//  AddTodoView.swift
//  todo_CR
//
//  Created by slava bily on 02.11.2020.
//

import SwiftUI

struct AddTodoView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var item = ""
    @State private var selectedPriority = 0
    @State private var showingAlert = false
    @State private var duplicatedItem = false
    
    var todos: FetchedResults<Todo>
    
    var prioriries = ["Low", "Medium", "High"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter item name", text: $item)
                }
                
                Section(header: Text("Set priority")) {
                    Picker("Select priority", selection: $selectedPriority) {
                        ForEach(0..<prioriries.count) {
                            Text(prioriries[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                 
                Section {
                    Button("Save") {
                        if !item.isEmpty {
                            for todo in todos {
                                if item == todo.item {
                                    // showing alert on duplicated todo item
                                    showingAlert.toggle()
                                    duplicatedItem.toggle()
                                    print("Duplicated Item...")
                                    return
                                }
                            }
                            let newTodo = Todo(context: moc)
                            newTodo.item = item
                            newTodo.priority = Int16(selectedPriority)
                            
                            try? moc.save()
                            
                        } else {
                            // show alert to user
                            showingAlert.toggle()
                            
                            return
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .alert(isPresented: $showingAlert, content: {
                if duplicatedItem == false {
                   return Alert(title: Text("Item is not entered"), message: Text("Please, enter the item name"), dismissButton: .default(Text("OK")))
                } else {
                  return  Alert(title: Text("Duplicated Item"), message: Text("Please, enter original"), dismissButton: .default(Text("OK")))
                }
            })
            .navigationBarTitle("Add todo")
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [])
    static var todos: FetchedResults<Todo>
    
    static var previews: some View {
        AddTodoView(todos: todos)
    }
}
