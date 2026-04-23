//
//  WeeklyProgressionView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 13/04/26.
//

import SwiftUI

struct WeeklyProgressionView: View {
    var currentLearnedPerWeek: Float
    var totalLearnedPerWeek: Float
    
    var progress: CGFloat {
        let raw = currentLearnedPerWeek / max(totalLearnedPerWeek, 1)
        return max(0, min(CGFloat(raw), 1.0))
    }
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .stroke(.white.opacity(0.3), lineWidth: 3)
                    .frame(width: 42, height: 42)
                
                Image(systemName: "target")
                    .foregroundColor(.white)
                    .font(.title)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Weekly Learned Vocabulary")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text("Progression will reset every monday")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        // Background bar
                        RoundedRectangle(cornerRadius: 12)
                            .frame(height: 24)
                            .foregroundColor(Color.white.opacity(0.3))
                        
                        // Foreground bar
                        RoundedRectangle(cornerRadius: 12)
                            .fill(
                                LinearGradient(
                                    colors: [.yellow, .orange],
                                    startPoint: .bottomLeading,
                                    endPoint: .topTrailing
                                )
                            )
                            .frame(width: geometry.size.width * progress, height: 24)
                            .animation(.easeInOut(duration: 0.6), value: progress)
                        
                        // Progression label
                        HStack {
                            Image(systemName: currentLearnedPerWeek >= totalLearnedPerWeek ? "trophy" : "progress.indicator")
                            
                            Text(
                                "\(currentLearnedPerWeek >= totalLearnedPerWeek ? "Mission Completed" : "On Progress") " +
                                "(\(Int(currentLearnedPerWeek))/\(Int(totalLearnedPerWeek)))"
                            )
                        }
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.leading)
                        .frame(height: 24, alignment: .leading)
                    }
                }
                .frame(height: 18)
            }
        }
        .padding(18)
        .background(
            LinearGradient(
                colors: [Color.green.opacity(0.9), Color.green.opacity(0.7)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.green.opacity(0.4), radius: 12, x: 0, y: 6)
        .padding(.horizontal)
    }
}

#Preview {
    WeeklyProgressionView(
        currentLearnedPerWeek: 1,
        totalLearnedPerWeek: 10
    )
}
