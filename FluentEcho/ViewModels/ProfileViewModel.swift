//
//  SettingsViewModel.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 11/04/26.
//

import Foundation
import Observation
import SwiftData

@Observable
class ProfileViewModel {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
        fetchUser()
    }
    
    var user: User?
    var isLoading: Bool = false
    var showAlert: Bool = false
    
    func fetchUser() {
        isLoading = true
        let descriptor = FetchDescriptor<User>()
        
        do {
            let fetchedUser = try context.fetch(descriptor)
            self.user = fetchedUser.first
            print("FETCH USER is performed!")
            
        } catch {
            print("Failed to fetch user: ", error)
        }
        isLoading = false
    }
    
    func addUpdateUser(name: String, interest: String, vocabularyPerWeek: Int) {
        isLoading = true
        
        // Error Handling
        if (name.isEmpty || interest.isEmpty) {
            showAlert = true
            isLoading = false
            return
        }
        
        if let existingUser = user {
            if (existingUser.interest != interest) {
                fetchAndUpdateVocabularies(selectedTag: existingUser.interest)
            }
            
            existingUser.name = name
            existingUser.interest = interest
            existingUser.vocabularyPerWeek = vocabularyPerWeek
            
        } else {
            let newUser = User(name: name, interest: interest, vocabularyPerWeek: vocabularyPerWeek)
            context.insert(newUser)
            user = newUser
        }
        
        do {
            try context.save()
            print("ADD or UPDATE USER is performed!")
            
        } catch {
            print("Failed to make changes on user's data: ", error)
        }
        isLoading = false
    }
    
    func deleteUser() {
        isLoading = true
        
        if let user {
            context.delete(user)
            self.user = nil
        }
        
        do {
            try context.save()
            print("DELETE USER is performed!")
            
        } catch {
            print("Failed to delete user: ", error)
        }
        isLoading = false
    }
    
    func fetchAndUpdateVocabularies(selectedTag: String) {
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
                
                for vocabulary in results {
                    vocabulary.isCompleted = false
                }
                
                // Reset user's prev interest progression
                existingUser.currentLearnedVocabulary = 0
                
                try context.save()
                
            } else {
                print("ERROR")
            }
            
        } catch {
            print("Failed to fetch vocabularies:", error)
        }
    }
}
