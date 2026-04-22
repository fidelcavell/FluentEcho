//
//  MissionItemCardView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 20/04/26.
//

import SwiftUI
import SwiftData

struct MissionItemCardView: View {
    @Environment(\.modelContext) private var context: ModelContext
    @StateObject private var speaker = SpeechManager()
    
    var viewModel: ContentViewModel
    var selectedVocabulary: Vocabulary
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Spacer()
                CustomSecondaryButton(
                    action: {
                        viewModel.updateLearnedStatus(byId: selectedVocabulary.id)
                    },
                    destination: EmptyView(),
                    isCanNavigate: false
                ) {
                    HStack {
                        Image(systemName: selectedVocabulary.isLearned ? "checkmark.circle" : "xmark.circle")
                        Text(selectedVocabulary.isLearned ? "Completed" : "Incomplete")
                            .fontWeight(.semibold)
                    }
                    .font(.caption)
                    .foregroundStyle(selectedVocabulary.isLearned ? .green : .red)
                }
            }
            
            Text(selectedVocabulary.word)
                .font(.largeTitle)
                .fontDesign(.rounded)
                .fontWeight(.bold)
            
            HStack(spacing: 12) {
                Text(selectedVocabulary.pronunciation)
                    .font(.title2)
                    .fontDesign(.rounded)
                
                CustomSecondaryButton(
                    action: {
                        speaker.speak(targetedText: selectedVocabulary.word)
                    },
                    destination: EmptyView(),
                    isCanNavigate: false
                ) {
                    Image(systemName: "speaker.wave.2")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(2)
                }
            }
            
            VStack(alignment: .center, spacing: 16) {
                Text(selectedVocabulary.meaningEN)
                    .font(.headline)
                
                Text(selectedVocabulary.meaningID)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .multilineTextAlignment(.center)
            .padding(.top, 24)
            
            Spacer()
            
            CustomPrimaryButton(
                action: {},
                destination: VocabularyLearnView(
                    context: context,
                    selectedVocabulary: selectedVocabulary
                ),
                isCanNavigate: true) {
                    HStack {
                        Image(systemName: "graduationcap")
                        Text("Learn Now")
                            .fontWeight(.semibold)
                    }
                    .padding(8)
                }
            
            Spacer()
        }
        .padding()
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 16)
        )
        .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 2)
        .padding(.horizontal)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    let context = container.mainContext
    
    MissionItemCardView(
        viewModel: ContentViewModel(context: context),
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
