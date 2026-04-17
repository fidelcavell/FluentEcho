//
//  VocabularyItemView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 13/04/26.
//

import SwiftUI

struct VocabularyItemView: View {
    @StateObject private var speaker = SpeechManager()
    
    var selectedVocabulary: Vocabulary
    var isSupportLeading: Bool
    
    var body: some View {
        NavigationStack {
            VStack(alignment: isSupportLeading ? .leading : .center, spacing: 16) {
                Text(selectedVocabulary.word)
                    .font(.largeTitle)
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
                
                HStack(spacing: 12) {
                    Text(selectedVocabulary.pronunciation)
                        .font(.title2)
                        .fontDesign(.rounded)
                    
                    CustomButtonView(
                        action: {
                            speaker.speak(targetedText: selectedVocabulary.word)
                        },
                        destination: EmptyView(),
                        isCanNavigate: false
                    ) {
                        Image(systemName: "speaker.wave.2")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(2)
                    }
                }
                
                VStack(alignment: isSupportLeading ? .leading : .center, spacing: 16) {
                    Text(selectedVocabulary.meaningEN)
                        .font(.headline)
                    
                    Text(selectedVocabulary.meaningID)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .multilineTextAlignment(isSupportLeading ? .leading : .center)
                .padding(.top, 24)
                
                // Appear only when this component got used in ContentView
                if !isSupportLeading {
                    NavigationLink {
                        VocabularyLearnView(
                            selectedVocabulary: selectedVocabulary
                        )
                    } label: {
                        HStack {
                            Image(systemName: "graduationcap") // better for vocab
                            Text("Learn")
                        }
                        .padding(8)
                    }
                    .buttonStyle(.glass)
                    .buttonBorderShape(.roundedRectangle(radius: 16))
                    .padding(.top, 62)
                }
                
            }
        }
        
    }
}

#Preview {
    VocabularyItemView(
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
        isSupportLeading: false
    )
}
