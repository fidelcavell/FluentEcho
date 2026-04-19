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
class SettingsViewModel {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
        fetchUser()
    }
    
    var user: User?
    var isLoading: Bool = false
    
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
        
        if let existingUser = user {
            existingUser.name = name
            existingUser.interest = interest
            existingUser.vocabularyPerWeek = vocabularyPerWeek
            
        } else {
            let newUser = User(name: name, interest: interest, vocabularyPerWeek: vocabularyPerWeek)
            context.insert(newUser)
            user = newUser
        }
        
//        user.name = name
//        user.interest = interest
//        user.vocabularyPerWeek = vocabularyPerWeek
        
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
        
//        user.name = "None"
//        user.interest = "None"
//        user.vocabularyPerWeek = 1
        
        do {
            try context.save()
            print("DELETE USER is performed!")
            
        } catch {
            print("Failed to delete user: ", error)
        }
        isLoading = false
    }
}
