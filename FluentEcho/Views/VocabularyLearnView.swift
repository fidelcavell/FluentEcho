//
//  VocabularyLearnView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 11/04/26.
//

import SwiftUI
import SwiftData

struct SelectedPracticeData: Identifiable, Equatable {
    let id = UUID()
    let index: Int
    let selectedVocabulary: Vocabulary
}

struct VocabularyLearnView: View {
    @Environment(\.modelContext) private var context: ModelContext
    @State private var viewModel: VocabularyLearnViewModel
    
    var selectedVocabulary: Vocabulary
    
    init(context: ModelContext, selectedVocabulary: Vocabulary) {
        _viewModel = State(initialValue: VocabularyLearnViewModel(context: context))
        self.selectedVocabulary = selectedVocabulary
    }
    
    @StateObject private var speaker = SpeechManager()
    @State private var selectedPractice: SelectedPracticeData?
    @State private var showPermissionAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                VocabularyItemView(
                    selectedVocabulary: selectedVocabulary,
                    isSupportLeading: true
                )
                
                Divider()
                    .padding(.vertical, 18)
                
                HStack {
                    Image(systemName: "book.badge.plus")
                        .font(.title2)
                    
                    Text("Practices")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
                VStack(spacing: 24) {
                    ForEach(selectedVocabulary.practiceSentencesEN.enumerated(), id: \.offset) { index, item in
                        HStack {
                            HStack(alignment: .firstTextBaseline) {
                                Text("\(index + 1).")
                                Text(item)
                            }
                            
                            Spacer()
                            
                            CustomSecondaryButton(
                                action: {
                                    selectedPractice = SelectedPracticeData(
                                        index: index,
                                        selectedVocabulary: selectedVocabulary
                                    )
                                },
                                destination: EmptyView(),
                                isCanNavigate: false,
                            ) {
                                HStack {
                                    Text("Learn")
                                    Image(systemName: "chevron.right.circle.fill")
                                }
                                .padding(2)
                            }
                        }
                    }
                }
                .sheet(item: $selectedPractice) { item in
                    RecordingPracticeView(
                        viewModel: viewModel,
                        selectedPractice: item,
                        dismissPracticeSheet: {
                            selectedPractice = nil
                            DispatchQueue.main.async {
                                showPermissionAlert = true
                            }
                        }
                    )
                    .presentationDetents([.fraction(0.6)])
                }
                .alert(isPresented: $showPermissionAlert) {
                    Alert(
                        title: Text("Permission Denied"),
                        message: Text("Microphone access is required to record your voice. Please enable it in settings."),
                        dismissButton: .default(Text("Ok")) {
                            //
                        }
                    )
                }
                
                Divider()
                    .padding(.vertical, 18)
                
                HStack {
                    HStack(spacing: 6) {
                        Image(systemName: "clock.arrow.circlepath")
                            .font(.title2)
                        
                        Text("Learn History")
                            .font(.title2.bold())
                        
                        Text("\(selectedVocabulary.learnHistory.count)")
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(4)
                            .background(Color.red)
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    CustomSecondaryButton(
                        action: {},
                        destination: LearnHistoryView(
                            selectedVocabulary: selectedVocabulary
                        ),
                        isCanNavigate: true,
                    ) {
                        HStack {
                            Text("View All")
                            Image(systemName: "chevron.right.circle.fill")
                        }
                        .padding(2)
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Learning Vocabulary")
            .padding(.horizontal, 28)
            .toolbar(.hidden, for: .tabBar)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    let context = container.mainContext
    
    VocabularyLearnView(
        context: context,
        selectedVocabulary: Vocabulary(
            word: "Agile",
            tag: "Technology",
            pronunciation: "a-jail",
            meaningEN: "A flexible and iterative approach to project management",
            meaningID: "Pendekatan yang fleksibel dan iteratif dalam manajemen proyek",
            practiceSentencesEN: [
                "Our team uses Agile to deliver features in short sprints.",
                "Agile allows quick adaptation to changes.",
                "Daily standups are part of Agile.",
            ],
            practiceSentencesID: [
                "Tim kami menggunakan Agile untuk menyampaikan fitur dalam sprint singkat.",
                "Agile memungkinkan adaptasi cepat terhadap perubahan.",
                "Standup harian adalah bagian dari Agile."
            ],
            learnHistory: []
        )
    )
}
