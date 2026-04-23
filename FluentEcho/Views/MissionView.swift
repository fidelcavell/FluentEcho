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
    @State private var viewModel: ContentViewModel
    @State private var currentIndex: Int = 0
    
    init(context: ModelContext) {
        _viewModel = State(initialValue: ContentViewModel(context: context))
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                if let user = viewModel.user {
                    AvatarAndNameView(username: user.name)
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
                    ForEach(0...4, id: \.self) { index in
                        Circle()
                            .fill(index == currentIndex ? Color.green : Color.gray.opacity(0.3))
                            .frame(width: 8, height: 8)
                    }
                }
                
                Spacer()
            }
            // Instead of task, maybe it can be changed by using .onAppear
            .task {
                if let interest = viewModel.user?.interest {
                    viewModel.fetchVocabularies(selectedTag: interest)
                }
            }
            
            // This can be deleted soon, if no data that would change dynamicly in this same screen
            .onChange(of: viewModel.user?.interest) { _, newValue in
                if let interest = newValue {
                    viewModel.fetchVocabularies(selectedTag: interest)
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
