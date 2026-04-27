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
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                Text("Let me know more about you")
                    .font(.title.bold())
                    .padding(.top, 24)
                
                // Name
                TextFieldWithLabelView(
                    labelTitle: "Name",
                    icon: "person",
                    placeholder: "Your name",
                    isDisable: false,
                    text: $name
                )
                
                // Interest
                SelectionFieldWithLabelView(
                    labelTitle: "Interest",
                    icon: "target",
                    text: $interest
                )
                
                // Vocabulary per week
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Image(systemName: "book.closed")
                        Text("Vocabulary per week")
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    
                    NumberStepperView(
                        value: $vocabularyPerWeek,
                        range: 1...10
                    )
                }
                
                CustomPrimaryButton(
                    action: {
                        viewModel.addUpdateUser(
                            name: name,
                            interest: interest,
                            vocabularyPerWeek: vocabularyPerWeek
                        )
                        // hasOnboarded = true
                    },
                    destination: EmptyView(),
                    isCanNavigate: false
                ) {
                    Text("Create your profile")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                
                Spacer()
            }
        }
        .padding(.horizontal, 28)
        .alert("Data must not be empty!", isPresented: $viewModel.showError) {
            Button("Got it", role: .cancel) {
                viewModel.showError = false
            }
        }
        .alert("Adding data successfully!", isPresented: $viewModel.showSuccess) {
            Button("Start learning now", role: .confirm) {
                viewModel.showSuccess = false
                hasOnboarded = true
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    let context = container.mainContext
    
    AddInitialUserView(context: context)
}
