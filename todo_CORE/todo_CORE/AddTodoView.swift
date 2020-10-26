//
//  AddTodoView.swift
//  todo_CORE
//
//  Created by slava bily on 25.10.2020.
//

import SwiftUI

struct AddTodoView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var item = ""
    @State private var selectedPriority = 0
    
    var prioriries = ["Low", "Medium", "High"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter item name", text: $item)
                    
                    
                }
                
                Picker("Select priority", selection: $selectedPriority) {
                    ForEach(0..<prioriries.count) {
                        Text(prioriries[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Section {
                    Button("Save") {
                        if !item.isEmpty {
                            let newTodo = Todo(context: moc)
                            newTodo.item = item
                            newTodo.priority = Int16(selectedPriority)
                            
                            try? moc.save()
                        } else {
                            // show alert to user
                            print("Item is empty...")
                            
                            return
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
