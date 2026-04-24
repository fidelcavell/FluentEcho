//
//  SearchVocabularyItemView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 20/04/26.
//

import SwiftUI
import SwiftData

struct ExploreItemView: View {
    @Environment(\.modelContext) private var context: ModelContext
    var selectedVocabulary: Vocabulary
    
    var body: some View {
        CustomSecondaryButton(
            action: {},
            destination: VocabularyLearnView(
                context: context,
                selectedVocabulary: selectedVocabulary
            ),
            isCanNavigate: true
        ) {
            HStack {
                Text(selectedVocabulary.word)
                    .font(.headline)
                    .fontDesign(.rounded)
                
                Spacer()
                
                HStack {
                    Image(systemName: selectedVocabulary.isCompleted ? "checkmark.circle" : "xmark.circle")
                    Text(selectedVocabulary.isCompleted ? "Completed" : "Incomplete")
                        .fontWeight(.semibold)
                }
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(selectedVocabulary.isCompleted ? Color.green : Color.red)
                .clipShape(Capsule())
            }
        }
    }
}

#Preview {
    ExploreItemView(
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
