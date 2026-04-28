//
//  SettingsView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 11/04/26.
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var viewModel: ProfileViewModel
    init(context: ModelContext) {
        _viewModel = State(initialValue: ProfileViewModel(context: context))
    }
    @AppStorage("hasOnboarded") var hasOnboarded: Bool?
    @AppStorage("isNotificationEnabled") private var isNotificationEnabled: Bool = false
    
    @State private var isUpdateMode: Bool = false
    @State private var isShowDeleteAlert: Bool = false
    @State private var isShowNotificationDenied: Bool = false
    
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
                        ScrollView {
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
                                    text: $name
                                )
                                
                                // Interest:
                                SelectionFieldWithLabelView(
                                    labelTitle: "Interest",
                                    icon: "target",
                                    text: $interest
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
                
                Toggle(isOn: $isNotificationEnabled) {
                    HStack(alignment: .top) {
                        Image(systemName: "bell")
                            .font(.title3)
                        
                        Text("Daily Reminder")
                            .font(.headline)
                    }
                }
                .onChange(of: isNotificationEnabled) { _, newValue in
                    if newValue {
                        // Check permission before scheduling notification
                        NotificationManager.shared.checkNotificationPermission { isGranted in
                            if isGranted {
                                viewModel.checkWeeklyProgressAndNotify()
                            } else {
                                isShowNotificationDenied = true
                                isNotificationEnabled = false
                            }
                        }
                    } else {
                        isNotificationEnabled = false
                        isShowNotificationDenied = true
                        NotificationManager.shared.cancelNotification()
                    }
                }
                .padding()
                .toggleStyle(SwitchToggleStyle(tint: .green))
                
                CustomSecondaryButton(
                    action: {
                        isShowDeleteAlert = true
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
                .alert("Are you sure to permanently delete this account?", isPresented: $isShowDeleteAlert) {
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
            .alert("Data must not be empty!", isPresented: $viewModel.showError) {
                Button("Ok", role: .cancel) {
                    viewModel.showError = false
                }
            }
            .alert(isPresented: $isShowNotificationDenied) {
                Alert(
                    title: Text("Allow notifications"),
                    message: Text("You need to allow FluentEcho to access notifications in order to use daily reminders."),
                    primaryButton: .default(Text("Open Settings")) {
                        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                        
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                    },
                    secondaryButton: .cancel() {
                        isShowNotificationDenied = false
                        isNotificationEnabled = false
                    }
                )
            }
            .onAppear {
                NotificationManager.shared.checkNotificationPermission { isGranted in
                    DispatchQueue.main.async {
                        isNotificationEnabled = isGranted
                    }
                }
                
                // Reset weekly learned vocabulary progression on every monday
                viewModel.resetProgressIfNeeded()
            }
            .onChange(of: scenePhase) { _, newPhase in
                if newPhase == .active {
                    NotificationManager.shared.checkNotificationPermission { isGranted in
                        DispatchQueue.main.async {
                            isNotificationEnabled = isGranted
                        }
                    }
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
