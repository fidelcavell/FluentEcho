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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
          
                Text("Weekly Learned Vocabulary")
            .font(.title3)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            
            HStack {
                Image(systemName: "target")
                
                Text("\(currentLearnedPerWeek, specifier: "%.f") / \(totalLearnedPerWeek, specifier: "%.f") words")
                    .font(.callout)
                
                ProgressView(value: currentLearnedPerWeek, total: totalLearnedPerWeek)
                    .scaleEffect(y: 2.0)
            }
            .foregroundStyle(.white)
            .tint(.white)
        }
        .padding(16)
        .background(Color.green.opacity(0.9))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.green.opacity(0.4), radius: 12, x: 0, y: 6)
        .padding(.top, 8)
        .padding(.horizontal, 32)
    }
}

#Preview {
    WeeklyProgressionView(
        currentLearnedPerWeek: 2,
        totalLearnedPerWeek: 9
    )
}
