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
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                VocabularyInformationCardView(
                    selectedVocabulary: selectedVocabulary,
                    updateLearnedStatusAction: {
                        viewModel.updateLearnedStatus(byId: selectedVocabulary.id)
                    }
                )
                
                Divider()
                    .padding(.vertical, 8)
                
                HStack {
                    Image(systemName: "book.badge.plus")
                    
                    VStack(alignment: .leading) {
                        Text("Practice Sentences")
                            .fontWeight(.bold)
                        
                        Text("Select a sentence below to practice your speaking")
                            .font(.caption)
                    }
                }
                .font(.title3)
                .foregroundStyle(.secondary)
                
                VStack(spacing: 24) {
                    ForEach(selectedVocabulary.practiceSentencesEN.enumerated(), id: \.offset) { index, item in
                        HStack {
                            HStack(alignment: .firstTextBaseline) {
                                Text("\(index + 1).")
                                Text(item)
                            }
                            .font(.callout)
                            .fontWeight(.semibold)
                            .fontDesign(.rounded)
                            
                            Spacer()
                            
                            CustomPrimaryButton(
                                action: {},
                                destination: RecordingPracticeView(
                                    context: context,
                                    selectedPractice: SelectedPracticeData(
                                        index: index,
                                        selectedVocabulary: selectedVocabulary
                                    ),
                                ),
                                isCanNavigate: true
                            ) {
                                HStack {
                                    Image(systemName: "microphone")
                                    
                                    Text("Speak Now")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                }
                                .padding(2)
                            }
                        }
                        
                    }
                }
                
                Divider()
                    .padding(.vertical, 8)
                
                VStack {
                    HStack {
                        HStack(spacing: 6) {
                            Image(systemName: "clock.arrow.circlepath")
                            
                            Text("Learning History")
                                .fontWeight(.bold)
                            
                            Text("\(selectedVocabulary.learnHistory.count)")
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(4)
                                .background(Color.red)
                                .clipShape(Circle())
                        }
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        CustomSecondaryButton(
                            action: {},
                            destination: LearningHistoryView(
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
                }
                
                Spacer()
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationTitle("Learning Vocabulary")
            .navigationBarTitleDisplayMode(.inline)
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
