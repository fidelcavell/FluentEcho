//
//  SettingsView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 11/04/26.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @State private var viewModel: SettingsViewModel
    init(context: ModelContext) {
        _viewModel = State(initialValue: SettingsViewModel(context: context))
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
//            HStack {
//                Text("Settings")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                
//                Spacer()
//                
//                CustomButtonView(
//                    action: {
//                        isUpdateMode = true
//                    },
//                    destination: EmptyView(),
//                    isCanNavigate: false
//                ) {
//                    Image(systemName: "pencil.circle.fill")
//                    Text("Update")
//                        .font(.headline)
//                        .padding(4)
//                }
//                .sheet(isPresented: $isUpdateMode) {
//                    VStack(alignment: .leading, spacing: 24) {
//                        Text("Update Profile")
//                            .font(.title3.bold())
//                        
//                        // Name:
//                        TextFieldWithLabelView(
//                            labelTitle: "Name",
//                            icon: "person",
//                            placeholder: "Your name",
//                            isDisable: false,
//                            bindedData: $name
//                        )
//                        
//                        // Interest:
//                        SelectionFieldWithLabelView(
//                            labelTitle: "Interest",
//                            icon: "target",
//                            bindedData: $interest
//                        )
//                        
//                        // Vocabulary per week:
//                        VStack(alignment: .leading, spacing: 16) {
//                            HStack {
//                                Image(systemName: "book.closed")
//                                Text("Vocabulary per week")
//                                    .font(.subheadline)
//                            }
//                            
//                            HStack {
//                                Stepper("", value: $vocabularyPerWeek, in: 1...10)
//                                    .labelsHidden()
//                                
//                                Spacer()
//                                
//                                Text("\(vocabularyPerWeek)")
//                                    .font(.title3)
//                                    .fontWeight(.semibold)
//                                    .frame(width: 40)
//                                    .padding(.vertical, 6)
//                                    .background(Color.gray.opacity(0.15))
//                                    .cornerRadius(12)
//                            }
//                        }
//                        
//                        CustomButtonView(
//                            action: {
//                                viewModel.addUpdateUser(
//                                    name: name,
//                                    interest: interest,
//                                    vocabularyPerWeek: vocabularyPerWeek
//                                )
//                                isUpdateMode = false
//                            },
//                            destination: EmptyView(),
//                            isCanNavigate: false
//                        ) {
//                            Text("Save Changes")
//                                .frame(maxWidth: .infinity)
//                                .padding()
//                        }
//                    }
//                    .padding(.horizontal, 28)
//                    .presentationDetents([.fraction(0.75)])
//                    .onAppear {
//                        name = viewModel.user.name
//                        interest = viewModel.user.interest
//                        vocabularyPerWeek = viewModel.user.vocabularyPerWeek
//                    }
//                }
//            }
//            .padding(.bottom, 24)
            
            // User's Profile
            VStack(spacing: 18) {
                TextFieldWithLabelView(
                    labelTitle: "Name",
                    icon: "person",
                    placeholder: "",
                    isDisable: true,
                    bindedData: $viewModel.user.name
                )
                
                TextFieldWithLabelView(
                    labelTitle: "Interest",
                    icon: "target",
                    placeholder: "",
                    isDisable: true,
                    bindedData: $viewModel.user.interest
                )
                
                TextFieldWithLabelView(
                    labelTitle: "Vocabulary Per Week",
                    icon: "book.closed",
                    placeholder: "",
                    isDisable: true,
                    bindedData: Binding(
                        get: {
                            String(viewModel.user.vocabularyPerWeek)
                        },
                        set: { newValue in
                            viewModel.user.vocabularyPerWeek = Int(newValue) ?? 0
                        }
                    )
                )
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
                    
                    CustomButtonView(
                        action: {
                            viewModel.addUpdateUser(
                                name: name,
                                interest: interest,
                                vocabularyPerWeek: vocabularyPerWeek
                            )
                            isUpdateMode = false
                        },
                        destination: EmptyView(),
                        isCanNavigate: false
                    ) {
                        Text("Save Changes")
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }
                .padding(.horizontal, 28)
                .presentationDetents([.fraction(0.75)])
                .onAppear {
                    name = viewModel.user.name
                    interest = viewModel.user.interest
                    vocabularyPerWeek = viewModel.user.vocabularyPerWeek
                }
            }
            
            Divider()
                .padding(.vertical, 18)
            
            // Account Preferences
            Text("Account Preferences")
                .font(.headline)
                .padding(.bottom, 16)
            
            CustomButtonView(
                action: {
                    isShowAlert = true
                },
                destination: EmptyView(),
                isCanNavigate: false
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
            
            Spacer()
        }
        .navigationTitle("Settings")
        .toolbar(content: {
            CustomButtonView(
                action: {
                    isUpdateMode = true
                },
                destination: EmptyView(),
                isCanNavigate: false
            ) {
                Image(systemName: "pencil.circle.fill")
                Text("Edit")
                    .font(.headline)
                    .padding(4)
            }
        })
        .padding(.horizontal, 28)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    let context = container.mainContext
    
    SettingsView(context: context)
}
