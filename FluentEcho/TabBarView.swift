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
            Tab("Mission", systemImage: "target") {
                MissionView(context: context)
            }
            
            Tab("Explore", systemImage: "magnifyingglass") {
                ExploreView(context: context)
            }
            
            Tab("Profile", systemImage: "person") {
                ProfileView(context: context)
            }
        }
        .tint(.green)
    }
}

#Preview {
    TabBarView()
}
