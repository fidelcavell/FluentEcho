//
//  SearchView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 20/04/26.
//

import SwiftUI
import SwiftData

struct SearchView: View {
    @State private var viewModel: ContentViewModel
    
    init(context: ModelContext) {
        _viewModel = State(initialValue: ContentViewModel(context: context))
    }
    
    @State private var searchText = ""
    
    var groupedVocabularies: [String: [Vocabulary]] {
        let filtered = viewModel.vocabularies.filter {
            searchText.isEmpty ||
            $0.word.localizedCaseInsensitiveContains(searchText)
        }
        
        let grouped = Dictionary(grouping: filtered) { vocab in
            String(vocab.word.prefix(1)).uppercased()
        }
        
        return grouped.mapValues { values in
            values.sorted {
                $0.word.localizedCaseInsensitiveCompare($1.word) == .orderedAscending
            }
        }
    }
    
    var sortedKeys: [String] {
        groupedVocabularies.keys.sorted()
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sortedKeys, id: \.self) { key in
                    Section(header: Text(key)) {
                        ForEach(groupedVocabularies[key] ?? [], id: \.id) { item in
                            SearchVocabularyItemView(
                                selectedVocabulary: item
                            )
                        }
                    }
                }
            }
            .task {
                if let interest = viewModel.user?.interest {
                    viewModel.fetchVocabularies(selectedTag: interest)
                }
            }
            .onChange(of: viewModel.user?.interest) { _, newValue in
                if let interest = newValue {
                    viewModel.fetchVocabularies(selectedTag: interest)
                }
            }
            .navigationTitle("Explore Vocabulary")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: "Search vocabulary...")
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    let context = container.mainContext
    
    SearchView(context: context)
}
