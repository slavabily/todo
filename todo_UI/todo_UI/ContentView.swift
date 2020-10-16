//
//  ContentView.swift
//  todo_UI
//
//  Created by slava bily on 14.10.2020.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var ns = NetworkService()
    
    var body: some View {
        VStack {
            Text("todo UI")
                .font(.headline)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {     
        ContentView()
    }
}

