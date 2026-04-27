//
//  SplashView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 11/04/26.
//

import SwiftUI
import SwiftData

struct SplashView: View {
    @Environment(\.modelContext) var context: ModelContext
    @AppStorage("hasOnboarded") var hasOnboarded: Bool = false
    
    @State private var scale: CGFloat = 0.6
    @State private var opacity: CGFloat = 0.0
    @State private var isActive: Bool = false
    
    var body: some View {
        ZStack {
            if isActive {
                if !hasOnboarded {
                    OnboardingView()
                } else {
                    TabBarView()
                }
            } else {
                Image("img_logo")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .scaleEffect(scale)
                    .opacity(opacity)
            }
        }
        .onAppear {
            // Logo's Animation
            withAnimation(.easeOut(duration: 0.8)) {
                scale = 1.1
                opacity = 1
            }
            
            // Bounce Effect
            withAnimation(.spring(
                response: 0.5,
                dampingFraction: 0.6
            ).delay(0.8)) {
                scale = 1.0
            }
            
            // Navigate after Delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                withAnimation {
                    isActive = true
                }
            }
        }
        .onAppear {
            DataSeeder(context: context).seedVocabularyData()
        }
    }
}

#Preview {
    SplashView()
}
