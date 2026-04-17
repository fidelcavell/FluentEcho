//
//  TextFieldWithLabelView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 11/04/26.
//

import SwiftUI

struct TextFieldWithLabelView: View {
    var labelTitle: String
    var icon: String
    var placeholder: String
    var isDisable: Bool
    @Binding var bindedData: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(labelTitle, systemImage: icon)
                .font(.headline)
            
            TextField(placeholder, text: $bindedData)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .disabled(isDisable)
        }
    }
}

#Preview {
    TextFieldWithLabelView(
        labelTitle: "Name",
        icon: "person",
        placeholder: "Your name",
        isDisable: false,
        bindedData: .constant("")
    )
}
