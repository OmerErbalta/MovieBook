//
//  HumanDetailCard.swift
//  LoodosProject
//
//  Created by OmerErbalta on 20.05.2024.
//

import Foundation
import SwiftUI


struct HumanDetailCardView: View {
    @Namespace var namespace
    let title: String
    let contents: [String]
    @State var showDetail:Bool = false
    init( title: String, content: String) {
        self.title = title
        self.contents  = content.split(separator: ",").map { String($0) }
        
    }
    var body: some View {
        if !showDetail{
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: Const.width * 0.07, height: Const.width * 0.07)
                    .foregroundColor(.black)
                Spacer()
                Text(title)
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer()
            }
            
            .padding()
            .frame(width: Const.width * 0.9)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .circular))
            .shadow(color: Color.black.opacity(0.5), radius: 3, x: 0, y: 3)
            .padding(.vertical, 3)
            .matchedGeometryEffect(id: "card", in: namespace)
            .onTapGesture {
                withAnimation (.spring(response: 0.4,dampingFraction: 0.4)){
                    showDetail.toggle()
                }
            }
        }
        else{
            VStack{
                ForEach(contents, id: \.self) { content in
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: Const.width * 0.05, height: Const.width * 0.05)
                            .foregroundColor(.black)
                        Spacer()
                        Text(content)
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                }
            }
            .padding()
            .frame(width: Const.width * 0.9)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
            .shadow(color: Color.black.opacity(0.5), radius: 3, x: 0, y: 3)
            .padding(.vertical, 3)
            .matchedGeometryEffect(id: "card", in: namespace)
            .onTapGesture {
                withAnimation (.spring(response: 0.25,dampingFraction: 0.8)){
                    showDetail.toggle()
                }
            }
            
        }
        
    }
}


