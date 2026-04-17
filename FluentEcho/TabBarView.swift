//
//  TabBarView.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 17/04/26.
//

import SwiftUI
import SwiftData

struct TabBarView: View {
    @Environment(\.modelContext) private var context: ModelContext
    
    var body: some View {
        TabView {
            Tab("Vocabulary", systemImage: "character.book.closed") {
                ContentView(context: context)
            }
            
            Tab("Settings", systemImage: "person") {
                SettingsView(context: context)
            }
            
            Tab(role: .search) {
                // DEVELOP - SOON
            }
        }
        .tint(.green)
    }
}

#Preview {
    TabBarView()
}
