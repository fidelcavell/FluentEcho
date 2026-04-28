//
//  SearchView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 20/04/26.
//

import SwiftUI
import SwiftData

enum FilterExplore: String, CaseIterable, Identifiable {
    case all = "All"
    case completed = "Completed"
    case inCompleted = "Incomplete"
    
    var id: String { rawValue }
}

struct ExploreView: View {
    @State private var viewModel: ExploreViewModel
    @State private var profileVM: ProfileViewModel
    
    init(context: ModelContext) {
        _viewModel = State(initialValue: ExploreViewModel(context: context))
        _profileVM = State(initialValue: ProfileViewModel(context: context))
    }
    
    @State private var searchText: String = ""
    @State private var selectedFilter: FilterExplore = .all
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Filter", selection: $selectedFilter) {
                    ForEach(FilterExplore.allCases) { filter in
                        Text(filter.rawValue)
                            .tag(filter)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                List {
                    ForEach(viewModel.sortedKeys, id: \.self) { key in
                        Section(header: Text(key)) {
                            ForEach(viewModel.groupedVocabularies[key] ?? [], id: \.id) { item in
                                ExploreItemView(
                                    selectedVocabulary: item
                                )
                            }
                        }
                    }
                }
            }
            .onAppear {
                if let interest = viewModel.user?.interest {
                    viewModel.fetchVocabularies(selectedTag: interest, targetedFilter: "")
                }
                
                // Reset weekly learned vocabulary progression on every monday
                profileVM.resetProgressIfNeeded()
            }
            .onChange(of: searchText) { _, newValue in
                viewModel.searchText = newValue
            }
            .onChange(of: selectedFilter) { _, newValue in
                if let user = viewModel.user {
                    viewModel.fetchVocabularies(selectedTag: user.interest, targetedFilter: selectedFilter.rawValue)
                }
            }
            .onChange(of: viewModel.user?.interest) { _, newValue in
                if let interest = newValue {
                    viewModel.fetchVocabularies(selectedTag: interest, targetedFilter: "")
                }
            }
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: "Search vocabulary...")
        }
        
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Vocabulary.self, configurations: config)
    let context = container.mainContext
    
    ExploreView(context: context)
}
