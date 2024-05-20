//
//  SearchBarModifier.swift
//  LoodosProject
//
//  Created by OmerErbalta on 18.05.2024.
//

import SwiftUI

struct SearchBarModifier: ViewModifier {
    @Binding var text: String

    func body(content: Content) -> some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            content
                
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(8)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

extension View {
    func searchBarStyle(text: Binding<String>) -> some View {
        self.modifier(SearchBarModifier(text: text))
    }
}
