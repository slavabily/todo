//
//  PriorityView.swift
//  todo_CORE
//
//  Created by slava bily on 26.10.2020.
//

import SwiftUI

struct PriorityView: View {
    
    var priority: Int
    
    var body: some View {
        switch priority {
        case 0:
            Circle().foregroundColor(.yellow)
        case 1:
            Circle().foregroundColor(.orange)
        default:
            Circle().foregroundColor(.red)
        }
    }
}

struct PriorityView_Previews: PreviewProvider {
    static var previews: some View {
        PriorityView(priority: 0)
    }
}
