//
//  OnboardingItemView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 11/04/26.
//

import SwiftUI

struct OnboardingItemView: View {
    var icon: String
    var headline: String
    var description: String
    var isLast: Bool
    var action: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            Circle()
                .fill(Color.green.opacity(0.1))
                .frame(width: 90, height: 90)
                .overlay(
                    Image(systemName: icon)
                        .font(.system(size: 36, weight: .semibold))
                        .foregroundColor(.green)
                )
            
            VStack(spacing: 12) {
                Text(headline)
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text(description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 24)
            .padding(.horizontal, 32)
            
            Spacer()
            
            if isLast {
                //
                Button(action: action) {
                    Text("Let's add your data!")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .buttonStyle(.glassProminent)
                .buttonBorderShape(.roundedRectangle(radius: 16))
                .tint(.green)
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
                
            } else {
                Spacer().frame(height: 80)
            }
        }
    }
}

#Preview {
    OnboardingItemView(
        icon: "globe",
        headline: "Learn Anywhere",
        description: "Access vocabulary anytime, anywhere. Build your skills on the go without limits.",
        isLast: true,
        action: {
            print("Tapped!")
        }
    )
}
