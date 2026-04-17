//
//  ContentViewModel.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 14/04/26.
//

import Foundation
import Observation
import SwiftData

@Observable
class ContentViewModel {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
        fetchUser()
    }
    
    var user: User = User(name: "None", interest: "None", vocabularyPerWeek: 1)
    var vocabularies: [Vocabulary] = []
    var isLoading: Bool = false
    
    // Cache variable:
    private var cachedVocabularies: [String: [Vocabulary]] = [:]
    
    func fetchUser() {
        isLoading = true
        let descriptor = FetchDescriptor<User>()
        do {
            self.user = try context.fetch(descriptor).first
            ?? User(name: "None", interest: "None", vocabularyPerWeek: 1)
            print("FETCH USER is performed!")
            
        } catch {
            print("Failed to fetch user: ", error)
        }
        isLoading = false
    }
    
    func fetchVocabularies(selectedTag: String) {
        isLoading = true
        
        // Checking cache availability and use it instead of reshuffle again
        if let cached = cachedVocabularies[selectedTag] {
            print("USING CACHE for tag:", selectedTag)
            vocabularies = cached
            isLoading = false
            return
        }
        
        // Define fetch data condition
        let descriptor = FetchDescriptor<Vocabulary>(
            predicate: #Predicate { item in
                item.tag == selectedTag
            }
        )
        
        do {
            // Fetch list of vocabulary with defined specific tag and shuffle it
            let results = try context.fetch(descriptor)
            let shuffled = Array(results.shuffled().prefix(25))
            
            vocabularies = shuffled
            
            // Store shuffled list result to temporary cache
            cachedVocabularies[selectedTag] = shuffled
            
            print("FETCH VOCABULARIES is performed: \(shuffled.count) items")
            
        } catch {
            print("Failed to fetch vocabularies:", error)
            self.vocabularies = []
        }
        isLoading = false
    }
    
    func searchVocabulary() {
        // TODO - Add logic to filter the list of vocabulary
    }
}
