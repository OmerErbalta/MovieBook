//
//  AlertManager.swift
//  LoodosProject
//
//  Created by OmerErbalta on 17.05.2024.
//

import Foundation
import SwiftUI

struct CustomAlert: View {
    @Binding var isActive: Bool

    let title: String
    let message: String
    let buttonTitle: String
    let action: () -> ()
    @State private var offset: CGFloat = Const.height

    var body: some View {
        ZStack {
            Color(.black)
                .opacity(isActive ?  0 : 0.3)
                .onTapGesture {
                    close()
                }

            VStack {
                Text(title)
                    .font(.title2)
                    .bold()
                    .padding()

                Text(message)
                    .font(.body)

                Button {
                    action()
                    close()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(uiColor: Const.primaryColor))

                        Text(buttonTitle)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                    }
                    .padding()
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay(alignment: .topTrailing) {
                Button {
                    close()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .fontWeight(.medium)
                }
                .tint(.red)
                .padding()
            }
            .shadow(radius: 10)
            .padding(10)
            .offset(x: 0, y: offset)
            .onAppear {
                withAnimation(.bouncy) {
                    offset = 0
                }
            }
        }
        .ignoresSafeArea()
    }

    func close() {
        withAnimation(.bouncy()) {
            offset = Const.height
            isActive = false
        }
    }
}


