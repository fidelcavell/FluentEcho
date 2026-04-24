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
class MissionViewModel {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
        fetchUser()
    }
    
    var user: User?
    var vocabularies: [Vocabulary] = []
    var isLoading: Bool = false
    
    // Cache variable:
    private var cachedVocabularies: [String: [Vocabulary]] = [:]
    
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
    
    func fetchVocabularies(selectedTag: String) {
        isLoading = true
        
        // Checking cache availability and use it instead of reshuffling again
        if let cached = cachedVocabularies[selectedTag] {
            print("USING CACHE for tag:", selectedTag)
            
            // Check if vocabularyPerWeek has changed
            if let existingUser = user {
                let oldVocabularyPerWeek = cached.count // Cached count (old value)
                let newVocabularyPerWeek = existingUser.vocabularyPerWeek // New value from user
                
                if oldVocabularyPerWeek != newVocabularyPerWeek {
                    // Adjust the cache based on the difference in vocabularyPerWeek
                    if newVocabularyPerWeek > oldVocabularyPerWeek {
                        // Add new items to the cache (fetch more vocabularies if needed)
                        let additionalCount = newVocabularyPerWeek - oldVocabularyPerWeek
                        // Assuming you want to add items from the fetched list (which is shuffled)
                        let descriptor = FetchDescriptor<Vocabulary>(
                            predicate: #Predicate { item in
                                item.tag == selectedTag
                            }
                        )
                        
                        do {
                            let results = try context.fetch(descriptor)
                            let additionalItems = Array(results.shuffled().prefix(additionalCount))
                            cachedVocabularies[selectedTag]?.append(contentsOf: additionalItems)
                            print("Cache updated with \(additionalCount) more items.")
                        } catch {
                            print("Failed to fetch additional vocabularies:", error)
                        }
                        
                    } else if newVocabularyPerWeek < oldVocabularyPerWeek {
                        // Remove items from the cache
                        let removalCount = oldVocabularyPerWeek - newVocabularyPerWeek
                        cachedVocabularies[selectedTag]?.removeLast(removalCount)
                        print("Cache updated with \(removalCount) fewer items.")
                    }
                }
            }
            
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
            if let existingUser = user {
                // Fetch list of vocabulary with defined specific tag and shuffle it
                let results = try context.fetch(descriptor)
                
                let shuffled = Array(results.shuffled().prefix(existingUser.vocabularyPerWeek))
                vocabularies = shuffled
                
                // Store shuffled list result to temporary cache
                cachedVocabularies[selectedTag] = shuffled
                print("FETCH VOCABULARIES is performed: \(shuffled.count) items")
                
            } else {
                print("No user has been found! [FetchVocabularies]")
            }
            
        } catch {
            print("Failed to fetch vocabularies:", error)
            self.vocabularies = []
        }
        
        isLoading = false
    }
    
    func updateLearnedStatus(byId id: UUID) {
        let descriptor = FetchDescriptor<Vocabulary>(
            predicate: #Predicate {
                $0.id == id
            }
        )
        
        do {
            guard let selectedVocabulary = try context.fetch(descriptor).first else {
                return
            }
            
            if let existingUser = user {
                existingUser.currentLearnedVocabulary += selectedVocabulary.isCompleted ? -1 : 1
                selectedVocabulary.isCompleted = !selectedVocabulary.isCompleted
                try context.save()
                
            } else {
                print("No user has been found! [UpdateLearnedStatus]")
            }
            
        } catch {
            print("Failed to update Vocabulary learning status: ", error)
        }
    }
}
