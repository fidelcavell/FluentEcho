//
//  RecordingPracticeView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 14/04/26.
//

import SwiftUI

struct RecordingPracticeView: View {
    @StateObject private var speaker = SpeechManager()
    
    var selectedPractice: selectedPracticeData
    
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Text("Let's Practice Your English!")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.vertical, 24)
            
            HStack(spacing: 18) {
                VStack(alignment: .leading, spacing: 12) {
                    Text(selectedPractice.selectedVocabulary.practiceSentencesEN[selectedPractice.index])
                        .font(.headline)
                    
                    Text(selectedPractice.selectedVocabulary.practiceSentencesID[selectedPractice.index])
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                Button {
                    speaker.speak(targetedText: selectedPractice.selectedVocabulary.practiceSentencesEN[selectedPractice.index])
                } label: {
                    Circle()
                        .frame(width: 42)
                        .foregroundStyle(.green)
                        .overlay {
                            Image(systemName: "speaker.wave.2")
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                }
            }
            
            Button {
                print("Record button tapped!")
            } label: {
                Circle()
                    .frame(width: 62)
                    .tint(.green)
                    .overlay {
                        Image(systemName: "microphone")
                            .font(.title2)
                            .foregroundStyle(.white)
                    }
            }
            .padding(.top, 36)
        }
        .padding(.horizontal, 28)
    }
}

#Preview {
    RecordingPracticeView(
        selectedPractice: selectedPracticeData(
            index: 1,
            selectedVocabulary: Vocabulary(
                word: "Agile",
                tag: "Technology",
                pronunciation: "a-jail",
                meaningEN: "A flexible and iterative approach to project management",
                meaningID: "Pendekatan fleksibel dan iteratif dalam manajemen proyek",
                practiceSentencesEN: [
                    "Our team uses Agile to deliver features in short sprints.",
                    "Agile allows quick adaptation to changes.",
                    "Daily standups are part of Agile.",
                ],
                practiceSentencesID: [
                    "Tim kami menggunakan Agile untuk merilis fitur dalam sprint singkat.",
                    "Agile memungkinkan adaptasi cepat terhadap perubahan.",
                    "Daily standup adalah bagian dari Agile."
                ],
                learnHistory: []
            )
        )
    )
}
