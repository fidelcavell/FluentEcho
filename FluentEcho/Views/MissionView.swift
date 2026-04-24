//
//  ContentView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 10/04/26.
//

import SwiftUI
import SwiftData

struct MissionView: View {
    @Environment(\.modelContext) private var context: ModelContext
    @State private var viewModel: MissionViewModel
    @State private var currentIndex: Int = 0
    
    init(context: ModelContext) {
        _viewModel = State(initialValue: MissionViewModel(context: context))
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                if let user = viewModel.user {
                    AvatarAndNameView(username: user.name)
                        .padding(.top)
                        .padding(.horizontal)
                    
                    WeeklyProgressionView(
                        currentLearnedPerWeek: Float(user.currentLearnedVocabulary),
                        totalLearnedPerWeek: Float(user.vocabularyPerWeek)
                    )
                }
                
                TabView(selection: $currentIndex) {
                    ForEach(viewModel.vocabularies.indices, id: \.self) { index in
                        MissionItemCardView(
                            viewModel: viewModel,
                            selectedVocabulary: viewModel.vocabularies[index]
                        )
                        .padding()
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(maxHeight: 500)
                
                HStack(spacing: 6) {
                    ForEach(viewModel.vocabularies.indices, id: \.self) { index in
                        Circle()
                            .fill(index == currentIndex ? Color.green : Color.gray.opacity(0.3))
                            .frame(width: 8, height: 8)
                    }
                }
                
                Spacer()
            }
            .onAppear {
                if let interest = viewModel.user?.interest {
                    viewModel.fetchVocabularies(selectedTag: interest)
                }
            }
            .onChange(of: viewModel.user?.interest) { oldValue, newValue in
                // If the interest has changed, refetch vocabularies
                if let interest = newValue {
                    viewModel.fetchVocabularies(selectedTag: interest)
                }
            }
            .onChange(of: viewModel.user?.vocabularyPerWeek) { _, newValue in
                // If the vocabulary per week changes, adjust the vocabulary count
                if let user = viewModel.user {
                    viewModel.fetchVocabularies(selectedTag: user.interest)
                }
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    let context = container.mainContext
    
    MissionView(context: context)
}
