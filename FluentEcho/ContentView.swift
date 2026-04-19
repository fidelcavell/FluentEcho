//
//  ContentView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 10/04/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context: ModelContext
    @State private var viewModel: ContentViewModel
    init(context: ModelContext) {
        _viewModel = State(initialValue: ContentViewModel(context: context))
    }
    
    @State private var currentIndex: Int? = 0
    @State private var isSearching: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                ScrollView(.vertical) {
                    VStack(spacing: 0) {
                        ForEach(viewModel.vocabularies.enumerated(), id: \.offset) { index, item in
                            VocabularyItemView(
                                selectedVocabulary: item,
                                isSupportLeading: false
                            )
                            .padding(.horizontal, 28)
                            .containerRelativeFrame(.vertical)
                            .id(index)
                        }
                    }
                }
                .task {
                    viewModel.fetchVocabularies(selectedTag: viewModel.user!.interest)
                }
                .onChange(of: viewModel.user!.interest) {
                    viewModel.fetchVocabularies(selectedTag: viewModel.user!.interest)
                }
                .scrollTargetLayout()
                .scrollTargetBehavior(.paging)
                .scrollIndicators(.hidden)
                .scrollPosition(id: $currentIndex)
                
                WeeklyProgressionView(
                    currentLearnedPerWeek: 1,
                    totalLearnedPerWeek: Float(viewModel.user!.vocabularyPerWeek)
                )
                .zIndex(1)
                
                // Add identifier to let user know that the vocabulary is focusing in a specific field (?)
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    let context = container.mainContext
    
    ContentView(context: context)
}
