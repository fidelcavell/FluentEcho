//
//  RecordingButton.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 18/04/26.
//

import SwiftUI
import SwiftData

struct RecordingButton: View {
    var viewModel: VocabularyLearnViewModel
    var dismissPracticeSheet: () -> Void
    
    var body: some View {
        VStack {
            Circle()
                .fill(viewModel.isRecording ? .red : .green)
                .frame(width: 82, height: 82)
                .overlay(
                    Image(systemName: "microphone")
                        .foregroundStyle(.white)
                        .font(.title)
                )
                .scaleEffect(viewModel.isRecording ? 1.2 : 1.0)
                .gesture(
                    LongPressGesture(minimumDuration: 0.2)
                        .onEnded { _ in
                            // Hold the mic button -> Start Recording
                            viewModel.startRecording()
                            
                            // Execute dismiss sheet when the permission is not granted
                            if !viewModel.isPermissionGranted {
                                dismissPracticeSheet()
                            }
                        }
                )
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onEnded {_ in
                            // Release the mic button -> Stop Recording
                            if viewModel.isRecording {
                                viewModel.stopRecording()
                            }
                            
                            
                            // TODO - Need to deep evaluate more!
                            if !viewModel.isPermissionGranted {
                                dismissPracticeSheet()
                            }
                        }
                )
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    let context = container.mainContext
    
    RecordingButton(
        viewModel: VocabularyLearnViewModel(context: context),
        dismissPracticeSheet: {}
    )
}
