//
//  ExploreViewModel.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 23/04/26.
//

import Foundation
import SwiftData
import Observation

@Observable
class ExploreViewModel {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
        fetchUser()
    }
    
    var user: User?
    var vocabularies: [Vocabulary] = []
    var isLoading: Bool = false
    
    var searchText: String = ""
    
    // Cache variable:
    private var cachedVocabularies: [String: [Vocabulary]] = [:]
    
    var groupedVocabularies: [String: [Vocabulary]] {
        let filtered = vocabularies.filter {
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
    
    func fetchUser() {
        let descriptor = FetchDescriptor<User>()
        
        do {
            let fetchedUser = try context.fetch(descriptor)
            self.user = fetchedUser.first
            print("FETCH USER is performed!")
            
        } catch {
            print("Failed to fetch user: ", error)
        }
    }
    
    func fetchVocabularies(selectedTag: String, targetedFilter: String) {
        isLoading = true
        
        let predicate: Predicate<Vocabulary> = {
            if targetedFilter == "Completed" {
                return #Predicate { $0.tag == selectedTag && $0.isCompleted }
            } else if targetedFilter == "Incomplete" {
                return #Predicate { $0.tag == selectedTag && !$0.isCompleted }
            } else {
                return #Predicate { $0.tag == selectedTag }
            }
        }()
        
        // Define fetch data condition
        let descriptor = FetchDescriptor<Vocabulary>(predicate: predicate)
        
        do {
            let results = try context.fetch(descriptor)
            vocabularies = results
            
            print("FETCH VOCABULARIES is performed: \(results.count) items")
            
        } catch {
            print("Failed to fetch vocabularies:", error)
            self.vocabularies = []
        }
        isLoading = false
    }
}
