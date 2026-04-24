//
//  RecordedPreviewCardView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 21/04/26.
//

import SwiftUI

struct RecordedPreviewCardView: View {
    @StateObject private var audio = AudioManager()
    
    var playbackPreview: () -> Void
    var savePreview: () -> Void
    var discardPreview: () -> Void
    
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
                        playbackPreview()
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
                        discardPreview()
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
                        savePreview()
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
    RecordedPreviewCardView(
        playbackPreview: {},
        savePreview: {},
        discardPreview: {}
    )
    .padding()
}
