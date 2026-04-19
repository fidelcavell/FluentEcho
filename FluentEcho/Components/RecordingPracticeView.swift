//
//  RecordingPracticeView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 14/04/26.
//

import SwiftUI
import SwiftData

struct RecordingPracticeView: View {
    @StateObject private var speaker = SpeechManager()
    
    var viewModel: RecordingViewModel
    var selectedPractice: SelectedPracticeData
    var dismissPracticeSheet: () -> Void
    
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
                VStack(spacing: 12) {
                    Text("Your Recording is Ready")
                        .font(.headline)
                    
                    HStack(spacing: 16) {
                        Button {
                            viewModel.playRecording()
                        } label: {
                            Image(systemName: "play.circle.fill")
                                .font(.largeTitle)
                                .foregroundStyle(.blue)
                        }
                        
                        Button {
                            viewModel.saveRecordingPractice(
                                targetedIndex: selectedPractice.index,
                                targetedVocabulary: selectedPractice.selectedVocabulary
                            )
                            viewModel.recordedAudioURL = nil // reset after save
                            
                        } label: {
                            Text("Save")
                                .padding()
                                .background(.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        Button {
                            if let url = viewModel.recordedAudioURL {
                                try? FileManager.default.removeItem(at: url)
                            }
                            viewModel.recordedAudioURL = nil
                            
                        } label: {
                            Text("Delete")
                                .padding()
                                .background(.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            
            RecordingButton(
                viewModel: viewModel,
                dismissPracticeSheet: dismissPracticeSheet
            )
            .padding(.top, 36)
        }
        .padding(.horizontal, 28)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: LearnHistory.self, configurations: config)
    let context = container.mainContext
    
    RecordingPracticeView(
        viewModel: RecordingViewModel(context: context),
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
        dismissPracticeSheet: {}
    )
}
