//
//  VocabularyLearnView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 11/04/26.
//

import SwiftUI

struct selectedPracticeData: Identifiable {
    let id = UUID()
    let index: Int
    let selectedVocabulary: Vocabulary
}

struct VocabularyLearnView: View {
    var selectedVocabulary: Vocabulary
    
    @StateObject private var speaker = SpeechManager()
    @State private var selectedPractice: selectedPracticeData?
    
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
                            
                            CustomButtonView(
                                action: {
                                    selectedPractice = selectedPracticeData(
                                        index: index,
                                        selectedVocabulary: selectedVocabulary
                                    )
                                },
                                destination: EmptyView(),
                                isCanNavigate: false
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
                        selectedPractice: item
                    )
                    .presentationDetents([.fraction(0.4)])
                }
                
                Divider()
                    .padding(.vertical, 18)
                
                HStack {
                    HStack(spacing: 6) {
                        Image(systemName: "clock")
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
                    
                    CustomButtonView(
                        action: {},
                        destination: LearnHistoryView(
                            selectedVocabulary: selectedVocabulary
                        ),
                        isCanNavigate: true
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
        }
    }
}

#Preview {
    VocabularyLearnView(
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
