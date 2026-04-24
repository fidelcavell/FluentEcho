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
    @State private var vocabularyPerWeek: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "info.circle")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                    
                    Text("Account Information")
                        .font(.title3)
                        .foregroundStyle(.secondary)
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
                        Text("Edit")
                            .font(.headline)
                            .padding(4)
                    }
                    .sheet(isPresented: $isUpdateMode) {
                        VStack(alignment: .leading, spacing: 24) {
                            HStack {
                                Text("Edit Profile")
                                    .font(.title2.bold())
                                
                                Spacer()
                                
                                CustomSecondaryButton(
                                    action: {
                                        isUpdateMode = false
                                    },
                                    destination: EmptyView(),
                                    isCanNavigate: false
                                ) {
                                    Image(systemName: "xmark")
                                        .font(.title3)
                                        .foregroundStyle(.red)
                                }
                            }
                            
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
                            .padding(.top)
                            
                            Spacer()
                        }
                        .padding(28)
                        .presentationDetents([.large])
                        .onAppear {
                            name = viewModel.user?.name ?? "None"
                            interest = viewModel.user?.interest ?? "None"
                            vocabularyPerWeek = viewModel.user?.vocabularyPerWeek ?? 0
                        }
                    }
                }
                .padding(.bottom)
                
                AccountInformationCardView(
                    name: viewModel.user?.name ?? "None",
                    interest: viewModel.user?.interest ?? "None",
                    vocabularyPerWeek: String(viewModel.user?.vocabularyPerWeek ?? 0)
                )
                
                Divider()
                    .padding(.vertical, 18)
                
                HStack {
                    Image(systemName: "person.crop.circle.badge.checkmark")
                    
                    Text("Account Preferences")
                        .fontWeight(.bold)
                }
                .font(.title3)
                .foregroundStyle(.secondary)
                .padding(.bottom, 16)
                
                CustomSecondaryButton(
                    action: {
                        isShowAlert = true
                    },
                    destination: EmptyView(),
                    isCanNavigate: false,
                ) {
                    HStack {
                        Image(systemName: "trash")
                        Text("Delete Account")
                            .font(.headline)
                        Spacer()
                    }
                    .foregroundStyle(.red)
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
            .navigationTitle("Personal Profile")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal)
            .alert("Data must not be empty!", isPresented: $viewModel.showAlert) {
                Button("Ok", role: .cancel) {
                    viewModel.showAlert = false
                }
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    let context = container.mainContext
    
    ProfileView(context: context)
}
