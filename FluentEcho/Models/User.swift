//
//  User.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 11/04/26.
//

import Foundation
import SwiftData

@Model
class User {
    var name: String
    var interest: String
    var currentLearnedVocabulary: Int
    var vocabularyPerWeek: Int
    
    init(name: String, interest: String, vocabularyPerWeek: Int) {
        self.name = name
        self.interest = interest
        self.currentLearnedVocabulary = 0
        self.vocabularyPerWeek = vocabularyPerWeek
    }
}
