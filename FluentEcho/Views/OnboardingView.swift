//
//  OnboardingView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 11/04/26.
//

import SwiftUI
import SwiftData

struct OnboardingItemData {
    let icon: String
    let headline: String
    let description: String
}

struct OnboardingView: View {
    @Environment(\.modelContext) private var context: ModelContext
    
    @State private var currentIndex = 0
    @State private var navigateToNext = false
    
    var onboardingData = [
        OnboardingItemData(
            icon: "globe",
            headline: "Learn Anywhere",
            description: "Access vocabulary anytime, anywhere. Build your skills on the go without limits."
        ),
        OnboardingItemData(
            icon: "book.closed",
            headline: "Expand Your Vocabulary",
            description: "Explore a curated list of words and phrases to strengthen your language foundation."
        ),
        OnboardingItemData(
            icon: "microphone",
            headline: "Practice by Speaking",
            description: "Record your voice and actively practice pronunciation with every word."
        ),
        OnboardingItemData(
            icon: "waveform.badge.magnifyingglass",
            headline: "Compare and Improve",
            description: "Listen and compare your recording with the correct pronunciation to refine your speech."
        )
    ]
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                // Onboarding Content:
                TabView(selection: $currentIndex) {
                    ForEach(0..<onboardingData.count, id: \.self) { index in
                        OnboardingItemView(
                            icon: onboardingData[index].icon,
                            headline: onboardingData[index].headline,
                            description: onboardingData[index].description,
                            isLast: index == onboardingData.count - 1,
                            action: {
                                navigateToNext = true
                            }
                        )
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                // Page's Indicator:
                HStack {
                    ForEach(0..<onboardingData.count, id: \.self) { index in
                        Circle()
                            .fill(currentIndex == index ? Color.green : Color.gray.opacity(0.3))
                            .frame(width: 8, height: 8)
                    }
                }
            }
            .navigationDestination(isPresented: $navigateToNext) {
                AddInitialUserView(context: context)
            }
        }
    }
}

#Preview {    
    OnboardingView()
}
