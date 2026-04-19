//
//  LearnHistoryView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 14/04/26.
//

import SwiftUI

struct LearnHistoryView: View {
    var selectedVocabulary: Vocabulary
    
    var body: some View {
        Group {
            if selectedVocabulary.learnHistory.isEmpty {
                VStack {
                    Text("Empty Learn History!")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            } else {
                ScrollView {
                    VStack {
                        ForEach(selectedVocabulary.learnHistory.reversed(), id: \.id) { item in
                            LearnHistoryItemView(
                                selectedLearnHistory: item
                            )
                        }
                    }
                    .padding(.top, 112)
                    .padding(.bottom, 48)
                }
                .ignoresSafeArea(edges: .vertical)
            }
        }
        .navigationTitle("Learning History")
    }
}

#Preview {
    LearnHistoryView(
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
