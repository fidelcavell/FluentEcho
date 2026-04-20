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
            
            Tab("Profile", systemImage: "person") {
                ProfileView(context: context)
            }
            
            Tab("Explore", systemImage: "magnifyingglass") {
                SearchView(context: context)
            }
        }
        .tint(.green)
    }
}

#Preview {
    TabBarView()
}
