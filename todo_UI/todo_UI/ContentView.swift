//
//  ContentView.swift
//  todo_UI
//
//  Created by slava bily on 14.10.2020.
//

import SwiftUI

struct ContentView: View {
    
    @State var todos = [Todo]()
    
    var body: some View {
        VStack {
            Text("todo UI")
                .font(.headline)
            List {
                ForEach(todos) { (item) in
                    Text(item.item)
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
            self.todos = todos.items
        } onError: { (errorMessage) in
            //show error to user
            debugPrint(errorMessage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
