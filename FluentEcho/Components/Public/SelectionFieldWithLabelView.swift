//
//  SelectionFieldWithLabelView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 11/04/26.
//

import SwiftUI

struct SelectionFieldWithLabelView: View {
    var labelTitle: String
    var icon: String
    @Binding var text: String
    
    private let selectionOptions = ["Technology", "Design"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Label(labelTitle, systemImage: icon)
                .font(.headline)
            
            ForEach(selectionOptions, id: \.self) { option in
                HStack {
                    Image(systemName: text == option ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(text == option ? .white : .green)
                    
                    Text(option)
                        .foregroundColor(text == option ? .white : .primary)
                    
                    Spacer()
                }
                .padding()
                .background(text == option ? .green : .gray.opacity(0.1))
                .cornerRadius(16)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        text = option
                    }
                }
            }
        }
    }
}

#Preview {
    SelectionFieldWithLabelView(
        labelTitle: "Interest",
        icon: "target",
        text: .constant("Technology")
    )
}
