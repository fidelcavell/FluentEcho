//
//  LearnHistory.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 14/04/26.
//

import Foundation
import SwiftData

@Model
class LearnHistory: Identifiable {
    @Attribute(.unique) var id: UUID
    var date: Date
    var recordedAudio: String

    @Relationship
    var vocabulary: Vocabulary
    
    init(date: Date, recordedAudio: String, vocabulary: Vocabulary) {
        self.id = UUID()
        self.date = date
        self.recordedAudio = recordedAudio
        self.vocabulary = vocabulary
    }
}
