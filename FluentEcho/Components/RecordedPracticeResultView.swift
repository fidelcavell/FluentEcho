//
//  RecordedPracticeResultView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 19/04/26.
//

import SwiftUI

struct RecordedPracticeResultView: View {
    var playbackDraft: () -> Void
    var saveRecordedDraft: () -> Void
    var deleteRecordedDraft: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 18) {
                Text("Your Recorded Draft is ready!")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                CustomPrimaryButton(
                    action: playbackDraft,
                    destination: EmptyView(),
                    isCanNavigate: false
                ) {
                    Image(systemName: "play.circle")
                        .font(.callout)
                }
            }
            
            HStack(spacing: 18) {
                CustomSecondaryButton(
                    action: {
                        deleteRecordedDraft()
                    },
                    destination: EmptyView(),
                    isCanNavigate: false
                ) {
                    Text("Delete")
                        .font(.caption)
                        .foregroundStyle(.red)
                }
                
                CustomSecondaryButton(
                    action: {
                        saveRecordedDraft()
                    },
                    destination: EmptyView(),
                    isCanNavigate: false
                ) {
                    Text("Save")
                        .font(.caption)
                }
            }
        }
        .padding(.vertical)
        .padding(.horizontal, 18)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 16)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.1))
        )
        .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    RecordedPracticeResultView(
        playbackDraft: {},
        saveRecordedDraft: {},
        deleteRecordedDraft: {}
    )
}
