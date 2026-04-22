//
//  VocabularyInformationCardView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 20/04/26.
//

import SwiftUI
import SwiftData

struct VocabularyInformationCardView: View {
    @StateObject private var speaker = SpeechManager()
    
    var selectedVocabulary: Vocabulary
    var updateLearnedStatusAction: () -> Void
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text(selectedVocabulary.word)
                        .font(.title)
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    CustomSecondaryButton(
                        action: {
                            updateLearnedStatusAction()
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
                
                HStack(spacing: 12) {
                    Text(selectedVocabulary.pronunciation)
                        .font(.title3)
                        .fontDesign(.rounded)
                    
                    CustomSecondaryButton(
                        action: {
                            speaker.speak(targetedText: selectedVocabulary.word)
                        },
                        destination: EmptyView(),
                        isCanNavigate: false,
                    ) {
                        Image(systemName: "speaker.wave.2")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(2)
                    }
                }
                
                VStack(alignment: .leading ,spacing: 16) {
                    Text(selectedVocabulary.meaningEN)
                        .font(.headline)
                    
                    Text(selectedVocabulary.meaningID)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .multilineTextAlignment(.leading)
                .padding(.top, 12)
            }
            .padding(18)
            .frame(maxWidth: .infinity)
            .background(
                .ultraThinMaterial,
                in: RoundedRectangle(cornerRadius: 16)
            )
            .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 2)
        }
    }
}

#Preview {
    VocabularyInformationCardView(
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
        ),
        updateLearnedStatusAction: {}
    )
}
