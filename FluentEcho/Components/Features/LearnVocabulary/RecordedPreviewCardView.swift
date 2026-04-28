//
//  RecordedPreviewCardView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 21/04/26.
//

import SwiftUI
import SwiftData

struct RecordedPreviewCardView: View {
    @ObservedObject var audio: AudioManager
    
    var viewModel: VocabularyLearnViewModel
    var selectedPractice: SelectedPracticeData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Recording Ready")
                        .font(.headline)
                    
                    Text("Preview your draft before saving")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                CustomSecondaryButton(
                    action: {
                        viewModel.audio.isPlaying ? viewModel.stopPreviewRecording() : viewModel.playPreviewRecording()
                    },
                    destination: EmptyView(),
                    isCanNavigate: false,
                    tint: audio.isPlaying ? .red : .green
                ) {
                    Image(systemName: audio.isPlaying ? "pause.fill" : "play.fill")
                }
            }
            
            HStack(spacing: 16) {
                CustomSecondaryButton(
                    action: {
                        if let url = viewModel.recordedAudioURL {
                            try? FileManager.default.removeItem(at: url)
                        }
                        viewModel.recordedAudioURL = nil
                    },
                    destination: EmptyView(),
                    isCanNavigate: false
                ) {
                    HStack {
                        Image(systemName: "trash")
                        Text("Discard")
                    }
                    .padding(.vertical, 8)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.red)
                    .frame(maxWidth: .infinity)
                }
                
                CustomPrimaryButton(
                    action: {
                        viewModel.saveRecordingPractice(
                            targetedIndex: selectedPractice.index,
                            targetedVocabulary: selectedPractice.selectedVocabulary
                        )
                    },
                    destination: EmptyView(),
                    isCanNavigate: false
                ) {
                    HStack {
                        Image(systemName: "square.and.arrow.down")
                        Text("Save")
                    }
                    .padding(.vertical, 8)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding()
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 16)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.primary.opacity(0.06))
        )
        .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Vocabulary.self, configurations: config)
    let context = container.mainContext
    
    RecordedPreviewCardView(
        audio: AudioManager(),
        viewModel: VocabularyLearnViewModel(context: context),
        selectedPractice: SelectedPracticeData(
            index: 1,
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
    )
}
