//
//  Vocabulary.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 11/04/26.
//

import Foundation
import SwiftData

@Model
class Vocabulary: Identifiable {
    @Attribute(.unique) var id: UUID
    var word: String
    var tag: String
    var isCompleted: Bool
    var pronunciation: String
    var meaningEN: String
    var meaningID: String
    var practiceSentencesEN: [String]
    var practiceSentencesID: [String]
    
    @Relationship(deleteRule: .cascade)
    var learnHistory: [LearnHistory]
    
    init(word: String, tag: String, pronunciation: String, meaningEN: String, meaningID: String, practiceSentencesEN: [String], practiceSentencesID: [String], learnHistory: [LearnHistory]) {
        self.id = UUID()
        self.word = word
        self.tag = tag
        self.isCompleted = false
        self.pronunciation = pronunciation
        self.meaningEN = meaningEN
        self.meaningID = meaningID
        self.practiceSentencesEN = practiceSentencesEN
        self.practiceSentencesID = practiceSentencesID
        self.learnHistory = learnHistory
    }
}
