//
//  LearnHistoryItemView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 15/04/26.
//

import SwiftUI

struct LearnHistoryItemView: View {
    //var selectedLearnHistory: LearnHistory
    
    @State private var isRecordPlaying: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("17 April 2026 - [Technology]")
                    .font(.headline)
                
                Spacer()
            }
            
            HStack(spacing: 8) {
                Text("Our team uses Agile to deliver features in short sprints.")
                    .font(.subheadline)
                
                Spacer()
                
                Button {
                    // TODO -> Able to playback recorded practice audio
                } label: {
                    Circle()
                        .frame(width: 42)
                        .foregroundStyle(.green)
                        .overlay {
                            Image(systemName: isRecordPlaying ? "pause.circle" : "play.circle")
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                }
            }
            .padding(.trailing, 8)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
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
    LearnHistoryItemView()
}
