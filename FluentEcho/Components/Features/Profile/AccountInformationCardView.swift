//
//  ProfileInformationCardView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 20/04/26.
//

import SwiftUI

struct AccountInformationCardView: View {
    var name: String
    var interest: String
    var vocabularyPerWeek: String
    
    var body: some View {
        VStack(spacing: 18) {
            TextFieldWithLabelView(
                labelTitle: "Name",
                icon: "person",
                placeholder: "",
                isDisable: true,
                text: .constant(name)
            )
            
            TextFieldWithLabelView(
                labelTitle: "Interest",
                icon: "target",
                placeholder: "",
                isDisable: true,
                text: .constant(interest)
            )
            
            TextFieldWithLabelView(
                labelTitle: "Vocabulary Per Week",
                icon: "book.closed",
                placeholder: "",
                isDisable: true,
                text: .constant(vocabularyPerWeek)
            )
        }
        .padding(24)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 16)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.1))
        )
        .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    AccountInformationCardView(
        name: "John Doe",
        interest: "Technology",
        vocabularyPerWeek: "2"
    )
}
