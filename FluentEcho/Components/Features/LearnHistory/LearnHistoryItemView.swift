//
//  LearnHistoryItemView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 15/04/26.
//

import SwiftUI

struct LearnHistoryItemView: View {
    @StateObject private var audio = AudioManager()
    var selectedLearnHistory: LearnHistory
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(selectedLearnHistory.date.formatted(
                    .dateTime
                        .weekday(.wide)
                        .day()
                        .month(.wide)
                        .year()
                        .hour(.twoDigits(amPM: .omitted))
                        .minute(.twoDigits)
                        .second(.twoDigits)
                ))
                .font(.headline)
                .fontDesign(.rounded)
                
                Spacer()
            }
            
            HStack(spacing: 8) {
                VStack(alignment: .leading) {
                    Text("Practice sentence:")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                    
                    Text(selectedLearnHistory.vocabulary.practiceSentencesEN[selectedLearnHistory.practiceSentenceIndex])
                        .font(.subheadline)
                }
                
                Spacer()
                
                CustomPrimaryButton(
                    action: {
                        if let url = URL(string: selectedLearnHistory.recordedAudio) {
                            audio.playback(url: url)
                            print(url)
                        }
                    },
                    destination: EmptyView(),
                    isCanNavigate: false
                ) {
                    Image(systemName: "play.circle")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
            }
            .padding(.trailing, 8)
        }
        .padding()
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 16)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.1))
        )
        .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
        .padding(.top, 8)
        .padding(.horizontal, 16)
    }
}

#Preview {
    LearnHistoryItemView(
        selectedLearnHistory: LearnHistory(
            date: Date(),
            practiceSentenceIndex: 1,
            recordedAudio: "",
            vocabulary: Vocabulary(
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
    )
}
