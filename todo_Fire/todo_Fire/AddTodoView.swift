//
//  AddTodoView.swift
//  todo_Fire
//
//  Created by slava bily on 30.11.2020.
//

import SwiftUI
import Firebase

struct AddTodoView: View {
    
    let ref = Database.database().reference(withPath: "todo-items")
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var todoItems: TodoItems
    
    @State private var item = ""
    @State private var selectedPriority = 0
    @State private var showingAlert = false
    @State private var duplicatedItem = false
    
    var prioriries = ["High", "Medium", "Low"]
    
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
                            for todo in todoItems.items {
                                if item == todo.name {
                                    // showing alert on duplicated todo item
                                    showingAlert.toggle()
                                    duplicatedItem.toggle()
                                    print("Duplicated Item...")
                                    return
                                }
                            }
                            let todoItem = TodoItem(name: item, priority: selectedPriority)
                            
                            let todoItemRef = ref.child(item.lowercased())
                            
                            todoItemRef.setValue(todoItem.toAnyObject())
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
     
    static var previews: some View {
        AddTodoView()
    }
}
