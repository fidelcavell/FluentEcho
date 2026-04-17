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
                    Image(systemName: bindedData == option ? "largecircle.fill.circle" : "circle")
                        .foregroundColor(.green)
                    
                    Text(option)
                    
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        bindedData = option
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.08))
                .cornerRadius(12)
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
