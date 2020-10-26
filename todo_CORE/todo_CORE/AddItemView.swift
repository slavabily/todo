//
//  AddItemView.swift
//  todo_CORE
//
//  Created by slava bily on 25.10.2020.
//

import SwiftUI

struct AddItemView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var item = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Item name", text: $item)
                }
                Section {
                    Button("Save") {
                        if !item.isEmpty {
                            let newTodo = Todo(context: moc)
                            newTodo.item = item
                            
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
        AddItemView()
    }
}
