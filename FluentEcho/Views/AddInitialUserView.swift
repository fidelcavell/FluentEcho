//
//  AddInitialUserInfoView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 11/04/26.
//

import SwiftUI
import SwiftData

struct AddInitialUserView: View {
    @State private var viewModel: ProfileViewModel
    init(context: ModelContext) {
        _viewModel = State(initialValue: ProfileViewModel(context: context))
    }
    
    @AppStorage("hasOnboarded") var hasOnboarded: Bool?
    
    @State private var name: String = ""
    @State private var interest: String = "Technology"
    @State private var vocabularyPerWeek: Int = 1
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            Text("Let me know more about you")
                .font(.title.bold())
                .padding(.top, 24)
            
            // Name:
            TextFieldWithLabelView(
                labelTitle: "Name",
                icon: "person",
                placeholder: "Your name",
                isDisable: false,
                bindedData: $name
            )
            
            // Interest:
            SelectionFieldWithLabelView(
                labelTitle: "Interest",
                icon: "target",
                bindedData: $interest
            )
            
            // Vocabulary per week:
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Image(systemName: "book.closed")
                    Text("Vocabulary per week")
                        .font(.subheadline)
                }
                
                HStack {
                    Stepper("", value: $vocabularyPerWeek, in: 1...10)
                        .labelsHidden()
                    
                    Spacer()
                    
                    Text("\(vocabularyPerWeek)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(width: 40)
                        .padding(.vertical, 6)
                        .background(Color.gray.opacity(0.15))
                        .cornerRadius(12)
                }
            }
            
            // Set Up Button:
            Button(action: {
                viewModel.addUpdateUser(
                    name: name,
                    interest: interest,
                    vocabularyPerWeek: vocabularyPerWeek
                )
                hasOnboarded = true
                
            }) {
                Text("Set Up")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .buttonStyle(.glassProminent)
            .buttonBorderShape(.roundedRectangle(radius: 16))
            .tint(.green)
            .padding(.top, 48)
            
            Spacer()
        }
        .padding(.horizontal, 28)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    let context = container.mainContext
    
    AddInitialUserView(context: context)
}
