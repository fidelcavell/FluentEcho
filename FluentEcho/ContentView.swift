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
                    VStack {
                        if viewModel.isLoading {
                            ProgressView()
                                .containerRelativeFrame(.vertical)
                        }
                        
                        ForEach(viewModel.vocabularies.enumerated(), id: \.offset) { index, item in
                            VocabularyItemView(
                                selectedVocabulary: item,
                                isSupportLeading: false
                            )
                            .padding(.horizontal, 16)
                            .containerRelativeFrame(.vertical)
                            .id(index)
                        }
                    }
                }
                .task {
                    viewModel.fetchVocabularies(selectedTag: viewModel.user.interest)
                }
                .onChange(of: viewModel.user.interest) {
                    viewModel.fetchVocabularies(selectedTag: viewModel.user.interest)
                }
                .scrollTargetLayout()
                .scrollTargetBehavior(.paging)
                .scrollIndicators(.hidden)
                .scrollPosition(id: $currentIndex)
                
                WeeklyProgressionView(
                    currentLearnedPerWeek: 1,
                    totalLearnedPerWeek: Float(viewModel.user.vocabularyPerWeek)
                )
                .zIndex(1)
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    // Left Side Button:
                    CustomButtonView(
                        action: {},
                        destination: SettingsView(context: context),
                        isCanNavigate: true
                    ) {
                        HStack {
                            Image(systemName: "person")
                            Text("Settings")
                        }
                    }
                    
                    if let index = currentIndex,
                       viewModel.vocabularies.indices.contains(index) {
                        
                        CustomButtonView(
                            action: {},
                            destination: VocabularyLearnView(
                                selectedVocabulary: viewModel.vocabularies[index]
                            ),
                            isCanNavigate: true
                        ) {
                            HStack {
                                Image(systemName: "book.badge.plus")
                                Text("Learn")
                            }
                            .padding(4)
                        }
                    }
                    
                    Spacer()
                    
                    // Right Side Button:
                    CustomButtonView(
                        action: {
                            isSearching = true
                        },
                        destination: EmptyView(),
                        isCanNavigate: false
                    ) {
                        Image(systemName: "magnifyingglass")
                    }
                    .sheet(isPresented: $isSearching) {
                        VStack {
                            Text("Hello, this is Search Sheet!")
                        }
                        .presentationDetents([.fraction(0.7)])
                    }
                }
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
