//
//  NumberStepperView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 22/04/26.
//

import SwiftUI

struct NumberStepperView: View {
    @Binding var value: Int
    let range: ClosedRange<Int>
    
    var body: some View {
        HStack(spacing: 24) {
            
            // Minus Button
            Button(action: decrement) {
                Image(systemName: "minus")
                    .font(.title2.bold())
                    .foregroundStyle(value > range.lowerBound ? .primary : .secondary)
                    .frame(width: 50, height: 50)
                    .background(Color.gray.opacity(0.15))
                    .clipShape(Circle())
            }
            .disabled(value <= range.lowerBound)
            
            // Value Display
            Text("\(value)")
                .font(.system(size: 28, weight: .bold))
                .frame(minWidth: 60)
                .padding(.vertical, 8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .contentTransition(.numericText())
            
            // Plus Button
            Button(action: increment) {
                Image(systemName: "plus")
                    .font(.title2.bold())
                    .foregroundStyle(value < range.upperBound ? .green : .gray)
                    .frame(width: 50, height: 50)
                    .background(Color.green.opacity(0.15))
                    .clipShape(Circle())
            }
            .disabled(value >= range.upperBound)
        }
        .frame(maxWidth: .infinity)
        .animation(.easeInOut(duration: 0.2), value: value)
    }
    
    // MARK: - Actions
    private func increment() {
        guard value < range.upperBound else { return }
        withAnimation {
            value += 1
        }
        haptic()
    }
    
    private func decrement() {
        guard value > range.lowerBound else { return }
        withAnimation {
            value -= 1
        }
        haptic()
    }
    
    private func haptic() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

#Preview {
    NumberStepperView(
        value: .constant(1),
        range: 1...10
    )
}
