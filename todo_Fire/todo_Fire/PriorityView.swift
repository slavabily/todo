//
//  PriorityView.swift
//  todo_Fire
//
//  Created by slava bily on 30.11.2020.
//

import SwiftUI

import SwiftUI

struct PriorityView: View {
    
    var color: Color {
        switch priority {
        case 0:
            return Color.yellow
        case 1:
            return Color.orange
        default:
            return Color.red
        }
    }
    
    var priority: Int
    
    var body: some View {
        
        Circle()
            .foregroundColor(color)
            .scaledToFit()
            .animation(
                Animation.easeInOut(duration: 1)
                    .repeatForever(autoreverses: true)

            )
    }
}

struct PriorityView_Previews: PreviewProvider {
    static var previews: some View {
        PriorityView(priority: 0)
    }
}

