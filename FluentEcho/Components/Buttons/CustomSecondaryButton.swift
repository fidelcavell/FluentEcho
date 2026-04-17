//
//  CustomSecondaryButton.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 17/04/26.
//

import SwiftUI

struct CustomSecondaryButton<Content: View, Destination: View>: View {
    // Regular Button
    var action: () -> Void
    
    // Navigation Link
    var destination: Destination
    var isCanNavigate: Bool
    
    @ViewBuilder
    var content: () -> Content
    
    var body: some View {
        Group {
            if isCanNavigate {
                NavigationLink {
                    destination
                } label: {
                    content()
                }
            } else {
                Button {
                    action()
                } label: {
                    content()
                }
            }
        }
        .buttonStyle(.glass)
        .buttonBorderShape(.roundedRectangle(radius: 16))
        .tint(.green)
    }
}

#Preview {
    CustomSecondaryButton(
        action: {},
        destination: EmptyView(),
        isCanNavigate: false,
        content: {
            HStack {
                Text("Front")
                Spacer()
                Text("Back")
            }
        }
    )
}
