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
        ScrollView {
            VStack {
                if !selectedVocabulary.learnHistory.isEmpty {
                    Text("EMPTY")
                    
                } else {
//                    ForEach(selectedVocabulary.learnHistory.enumerated(), id: \.offset) { index, item in
//                        LearnHistoryItemView()
//                    }
                    
                                    ForEach(1...15, id: \.self) { _ in
                                        LearnHistoryItemView()
                                    }
                }
            }
            .padding(.top, 112)
            .padding(.bottom, 48)
        }
        .navigationTitle("Learn History")
        .ignoresSafeArea(edges: .vertical)
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
