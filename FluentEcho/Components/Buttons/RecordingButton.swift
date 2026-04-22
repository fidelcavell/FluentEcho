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
    
    @Binding var showPermissionAlert: Bool
    
    var body: some View {
        Circle()
            .fill(viewModel.isRecording ? Color.red : Color.green)
            .frame(width: 82, height: 82)
            .shadow(
                color: .black.opacity(viewModel.isRecording ? 0.4 : 0.2),
                radius: viewModel.isRecording ? 10 : 4, x: 0, y: viewModel.isRecording ? 6 : 2
            )
            .overlay(
                Image(systemName: "microphone")
                    .font(.title)
                    .foregroundStyle(.white)
            )
            .scaleEffect(viewModel.isRecording ? 1.3 : 1.0)
            .animation(
                .spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.3),
                value: viewModel.isRecording
            )
            .gesture(
                LongPressGesture(minimumDuration: 0.2)
                    .onEnded { _ in
                        // Hold the mic button -> Start Recording
                        showPermissionAlert = false
                        viewModel.startRecording()
                    }
            )
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onEnded {_ in
                        // Release the mic button -> Stop Recording
                        if viewModel.isRecording {
                            viewModel.stopRecording()
                        }
                        
                        // Execute "Dismiss practice sheet" when the permission is not granted
                        if !viewModel.isPermissionGranted {
                            viewModel.recordedAudioURL = nil
                            showPermissionAlert = true
                        }
                    }
            )
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: LearnHistory.self, configurations: config)
    let context = container.mainContext
    
    RecordingButton(
        viewModel: VocabularyLearnViewModel(context: context),
        showPermissionAlert: .constant(false)
    )
}
