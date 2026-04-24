//
//  AvatarAndNameView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 23/04/26.
//

import SwiftUI

struct AvatarAndNameView: View {
    var username: String
    
    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 5..<12:
            return "Good Morning"
        case 12..<17:
            return "Good Afternoon"
        default:
            return "Good Night"
        }
    }
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(.ultraThinMaterial)
                    .frame(width: 52, height: 52)
                
                Text(username
                    .split(separator: " ")
                    .prefix(2)
                    .map { String($0.prefix(1)) }
                    .joined()
                    .uppercased()
                )
                .fontWeight(.semibold)
            }
            
            VStack(alignment: .leading) {
                Text("\(greeting)!")
                    .font(.callout)
                
                Text(username)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
            }
            
            Spacer()
        }
    }
}

#Preview {
    AvatarAndNameView(
        username: "Albert John Doe"
    )
}
