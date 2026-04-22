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
    @Binding var bindedData: String
    
    private let selectionOptions = ["Technology", "Design"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Label(labelTitle, systemImage: icon)
                .font(.headline)
            
            ForEach(selectionOptions, id: \.self) { option in
                HStack {
                    Image(systemName: bindedData == option ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(bindedData == option ? .white : .green)
                    
                    Text(option)
                        .foregroundColor(bindedData == option ? .white : .primary)
                    
                    Spacer()
                }
                .padding()
                .background(bindedData == option ? .green : .gray.opacity(0.1))
                .cornerRadius(16)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        bindedData = option
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
        bindedData: .constant("Technology")
    )
}
