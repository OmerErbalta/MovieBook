//
//  MovieDetailText.swift
//  LoodosProject
//
//  Created by OmerErbalta on 20.05.2024.
//

import Foundation
import SwiftUI
struct MovieDetailText: View {
    let header: String
    let value: String
    
    var body: some View {
        VStack {
            HStack {
                Text("\(header):")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
                Text(value)
                    .font(.system(size: 12))
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
            }
            Divider()
        }
    }
}
