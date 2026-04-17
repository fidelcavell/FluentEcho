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
    
    var user: User = User(name: "None", interest: "None", vocabularyPerWeek: 1)
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
    
    func addUpdateUser(name: String, interest: String, vocabularyPerWeek: Int) {
        isLoading = true
        
        user.name = name
        user.interest = interest
        user.vocabularyPerWeek = vocabularyPerWeek
        
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
        
        user.name = "None"
        user.interest = "None"
        user.vocabularyPerWeek = 1
        
        do {
            try context.save()
            print("DELETE USER is performed!")
            
        } catch {
            print("Failed to delete user: ", error)
        }
        isLoading = false
    }
}
