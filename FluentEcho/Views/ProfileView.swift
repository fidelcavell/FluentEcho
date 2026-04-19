//
//  SettingsView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 11/04/26.
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    @State private var viewModel: ProfileViewModel
    init(context: ModelContext) {
        _viewModel = State(initialValue: ProfileViewModel(context: context))
    }
    @AppStorage("hasOnboarded") var hasOnboarded: Bool?
    
    @State private var isUpdateMode: Bool = false
    @State private var isShowAlert: Bool = false
    
    // Editing variable State
    @State private var name: String = ""
    @State private var interest: String = ""
    @State private var vocabularyPerWeek: Int = 1
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Profile")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                CustomPrimaryButton(
                    action: {
                        isUpdateMode = true
                    },
                    destination: EmptyView(),
                    isCanNavigate: false,
                ) {
                    Image(systemName: "pencil.circle.fill")
                    Text("Update")
                        .font(.headline)
                        .padding(4)
                }
                .sheet(isPresented: $isUpdateMode) {
                    VStack(alignment: .leading, spacing: 24) {
                        Text("Update Profile")
                            .font(.title3.bold())
                        
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
                                    .font(.headline)
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
                        
                        CustomPrimaryButton(
                            action: {
                                viewModel.addUpdateUser(
                                    name: name,
                                    interest: interest,
                                    vocabularyPerWeek: vocabularyPerWeek
                                )
                                isUpdateMode = false
                            },
                            destination: EmptyView(),
                            isCanNavigate: false,
                        ) {
                            Text("Save Changes")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                    }
                    .padding(.horizontal, 28)
                    .presentationDetents([.fraction(0.75)])
                    .onAppear {
                        name = viewModel.user?.name ?? "None"
                        interest = viewModel.user?.interest ?? "None"
                        vocabularyPerWeek = viewModel.user?.vocabularyPerWeek ?? 0
                    }
                }
            }
            .padding(.bottom, 24)
            
            // User's Profile
            VStack(spacing: 18) {
                TextFieldWithLabelView(
                    labelTitle: "Name",
                    icon: "person",
                    placeholder: "",
                    isDisable: true,
                    bindedData: Binding(
                        get: { viewModel.user?.name ?? "No name" },  // Default value if user is nil
                        set: { newValue in
                            viewModel.user?.name = newValue
                        }
                    )
                )
                
                TextFieldWithLabelView(
                    labelTitle: "Interest",
                    icon: "target",
                    placeholder: "",
                    isDisable: true,
                    bindedData: Binding(
                        get: { viewModel.user?.interest ?? "No interest" },  // Default value if user is nil
                        set: { newValue in
                            viewModel.user?.interest = newValue
                        }
                    )
                )
                
                TextFieldWithLabelView(
                    labelTitle: "Vocabulary Per Week",
                    icon: "book.closed",
                    placeholder: "",
                    isDisable: true,
                    bindedData: Binding(
                        get: { String(viewModel.user?.vocabularyPerWeek ?? 0) },  // Default value if user is nil
                        set: { newValue in
                            viewModel.user?.vocabularyPerWeek = Int(newValue) ?? 0
                        }
                    )
                )
            }
            
            Divider()
                .padding(.vertical, 18)
            
            // Account Preferences
            Text("Account Preferences")
                .font(.headline)
                .padding(.bottom, 16)
            
            CustomSecondaryButton(
                action: {
                    isShowAlert = true
                },
                destination: EmptyView(),
                isCanNavigate: false,
            ) {
                HStack {
                    Text("Delete Account")
                        .font(.headline)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right.circle.fill")
                }
                .padding(8)
            }
            .alert("Are you sure to permanently delete this account?", isPresented: $isShowAlert) {
                Button("Delete", role: .destructive) {
                    viewModel.deleteUser()
                    hasOnboarded = false
                }
            }
            .tint(.black)
            
            Spacer()
        }
        .padding(.horizontal, 28)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    let context = container.mainContext
    
    ProfileView(context: context)
}
