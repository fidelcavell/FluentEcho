//
//  FluentEchoApp.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 10/04/26.
//

import SwiftUI
import SwiftData

@main
struct FluentEchoApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
        .modelContainer(for: DatabaseSchema.all)
    }
}
