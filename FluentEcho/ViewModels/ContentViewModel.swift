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
        
        let descriptor = FetchDescriptor<Vocabulary>(
            predicate: #Predicate { item in
                item.tag == selectedTag
            }
        )
        
        do {
            let results = try context.fetch(descriptor)
            self.vocabularies = Array(results.shuffled().prefix(25))
            
            print("FETCH VOCABULARIES is performed: \(vocabularies.count) items")
            
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
