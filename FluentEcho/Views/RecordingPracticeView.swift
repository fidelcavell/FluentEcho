//
//  RecordingPracticeView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 20/04/26.
//

import SwiftUI
import SwiftData

struct RecordingPracticeView: View {
    @StateObject private var speaker = SpeechManager()
    
    @State private var viewModel: VocabularyLearnViewModel
    var selectedPractice: SelectedPracticeData
    
    init(context: ModelContext, selectedPractice: SelectedPracticeData) {
        _viewModel = State(initialValue: VocabularyLearnViewModel(context: context))
        self.selectedPractice = selectedPractice
    }
    
    @State private var showPermissionAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
                Image(systemName: "book.badge.plus")
                    .font(.title2)
                
                VStack(alignment: .leading) {
                    Text("Practice Sentence")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text("Try to speak the sentence below")
                        .font(.caption)
                }
            }
            .foregroundStyle(.secondary)
            
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 12) {
                    Text(selectedPractice.selectedVocabulary.practiceSentencesEN[selectedPractice.index])
                        .font(.headline)
                    Text(selectedPractice.selectedVocabulary.practiceSentencesID[selectedPractice.index])
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                CustomSecondaryButton(
                    action: {
                        speaker.speak(targetedText: selectedPractice.selectedVocabulary.practiceSentencesEN[selectedPractice.index])
                    },
                    destination: EmptyView(),
                    isCanNavigate: false
                ) {
                    Image(systemName: "speaker.wave.2")
                        .font(.title2)
                        .fontWeight(.bold)
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
            
            if viewModel.hasPreview {
                Divider()
                    .padding(.vertical, 12)
                
                HStack {
                    Image(systemName: "waveform")
                        .font(.title2)
                    
                    Text("Audio Preview")
                        .font(.title3)
                        .fontWeight(.bold)
                }
                .foregroundStyle(.secondary)
                
                RecordedPreviewCardView(
                    playbackPreview: {
                        viewModel.playPreviewRecording()
                    },
                    savePreview: {
                        viewModel.saveRecordingPractice(
                            targetedIndex: selectedPractice.index,
                            targetedVocabulary: selectedPractice.selectedVocabulary
                        )
                        viewModel.recordedAudioURL = nil
                    },
                    discardPreview: {
                        if let url = viewModel.recordedAudioURL {
                            try? FileManager.default.removeItem(at: url)
                        }
                        viewModel.recordedAudioURL = nil
                    }
                )
            } else {
                HStack {
                    Spacer()
                    
                    VStack(spacing: 16) {
                        RecordingButton(
                            viewModel: viewModel,
                            showPermissionAlert: $showPermissionAlert
                        )
                        Text("Hold to Speak")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                }
                .alert(isPresented: $showPermissionAlert) {
                    Alert(
                        title: Text("Permission Denied"),
                        message: Text("Microphone access is required to record your voice. Please enable it in settings."),
                        dismissButton: .default(Text("Ok")) {
                            // Do Nothing
                        }
                    )
                }
                .padding(.top, 52)
            }
            
            Spacer()
        }
        .onAppear {
            viewModel.recordedAudioURL = nil
        }
        .padding(28)
        .navigationTitle("Recording Practice")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: LearnHistory.self, configurations: config)
    let context = container.mainContext
    
    NavigationStack {
        RecordingPracticeView(
            context: context,
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
            )
        )
    }
}
