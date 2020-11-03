//
//  TodoCell.swift
//  todo_CR
//
//  Created by slava bily on 03.11.2020.
//

import SwiftUI

struct TodoCell: View {
    
    var item: String
    var priority: Int
    
    var body: some View {
        HStack {
            Text(item)
                .font(.headline)
                .frame(width: 300, alignment: .leading)
            
            switch priority {
            case 0: Circle()
                .foregroundColor(.yellow)
            case 1: Circle()
                .foregroundColor(.orange)
            default: Circle()
                .foregroundColor(.red)
            }
        }
        
    }
}


struct TodoCell_Previews: PreviewProvider {
    static var previews: some View {
        TodoCell(item: "Clean the house", priority: 1)
    }
}

