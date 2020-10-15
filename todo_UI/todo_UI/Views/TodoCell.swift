//
//  TodoCell.swift
//  todo_UI
//
//  Created by slava bily on 14.10.2020.
//

import SwiftUI

struct TodoCell: View {
    
    @State private var item = "Clean the house"
    
    var body: some View {
        HStack {
            TextField("", text: $item)
                .font(.headline)
                .frame(width: 300, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Spacer(minLength: 50)
                
            Circle()
                .foregroundColor(.red)
                
        }
        
    }
}

struct TodoCell_Previews: PreviewProvider {
    static var previews: some View {
        TodoCell()
    }
}
