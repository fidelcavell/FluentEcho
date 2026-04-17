//
//  DatabaseSchema.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 11/04/26.
//

import Foundation
import SwiftData

struct DatabaseSchema {
    static let all: [any PersistentModel.Type] = [
        User.self,
        Vocabulary.self,
        LearnHistory.self
    ]
}
