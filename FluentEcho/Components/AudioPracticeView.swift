//
//  RecordingPracticeView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 14/04/26.
//

import SwiftUI
import SwiftData

struct AudioPracticeView: View {
    @StateObject private var speaker = SpeechManager()
    
    var viewModel: VocabularyLearnViewModel
    var selectedPractice: SelectedPracticeData
    var dismissPracticeSheet: () -> Void
    
    @Binding var showPermissionAlert: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                HStack {
                    Text("Let's Practice Your English!")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.vertical)
                
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
                            .frame(width: 52)
                            .foregroundStyle(.green)
                            .overlay {
                                Image(systemName: "speaker.wave.2")
                                    .font(.title2)
                                    .foregroundStyle(.white)
                            }
                    }
                }
                
                if viewModel.hasPreview {
                    RecordedPracticeResultView(
                        playbackDraft: {
                            viewModel.playRecording()
                        },
                        saveRecordedDraft: {
                            viewModel.saveRecordingPractice(
                                targetedIndex: selectedPractice.index,
                                targetedVocabulary: selectedPractice.selectedVocabulary
                            )
                            
                            // To reset current recorded audio URL
                            dismissPracticeSheet()
                            
                            print("SAVE BUTTON get pressed!")
                        },
                        deleteRecordedDraft: {
                            if let url = viewModel.recordedAudioURL {
                                try? FileManager.default.removeItem(at: url)
                            }
                            viewModel.recordedAudioURL = nil
                        }
                    )
                    .padding(.top)
                }
                
                RecordingButton(
                    viewModel: viewModel,
                    dismissPracticeSheet: dismissPracticeSheet,
                    showPermissionAlert: $showPermissionAlert
                )
                .padding(.top, 24)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: dismissPracticeSheet) {
                        Image(systemName: "xmark")
                    }
                }
            }
            .padding(.horizontal, 28)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: LearnHistory.self, configurations: config)
    let context = container.mainContext
    
    AudioPracticeView(
        viewModel: VocabularyLearnViewModel(context: context),
        selectedPractice: SelectedPracticeData(
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
        ),
        dismissPracticeSheet: {},
        showPermissionAlert: .constant(false)
    )
}
