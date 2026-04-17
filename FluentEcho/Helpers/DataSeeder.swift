//
//  DataSeeder.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 14/04/26.
//

import Foundation
import SwiftData

struct RawVocabulary: Codable {
    let word: String
    let tag: String
    let pronunciation: String
    let meaningEN: String
    let meaningID: String
    let practiceSentencesEN: [String]
    let practiceSentencesID: [String]
}

class DataSeeder {
    private var context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func seedVocabularyData() {
        let descriptor = FetchDescriptor<Vocabulary>()
        
        do {
            let existingTechVocabulary = try context.fetch(descriptor)
            
            if existingTechVocabulary.isEmpty {
                for techItem in InitialTechVocabularyData.shared.rawTechVocabularyData {
                    context.insert(techItem)
                }
                
                for designItem in InitialDesignVocabularyData.shared.rawDesignVocabularyData {
                    context.insert(designItem)
                }
                try context.save()
                print("Database successfully seeded!")
                
            } else {
                print("Database already has been seeded!")
            }
            
        } catch {
            print("Database seeding got an error: ", error)
        }
    }
}
