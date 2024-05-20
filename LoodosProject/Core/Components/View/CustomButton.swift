//
//  CustomButton.swift
//  LoodosProject
//
//  Created by OmerErbalta on 18.05.2024.
//

import Foundation
import SwiftUI

struct CustomButton : View{
    let image:Image
    let imageColor:Color
    let cornerRadius:CGFloat
    let padding:CGFloat
    let buttonColor:Color
    var action:()->Void
    init( image: Image, imageColor: Color = .white,buttonColor:Color = .blue,padding:CGFloat = 5,cornerRadius:CGFloat = 5,action:@escaping ()->Void) {
        self.image = image
        self.imageColor = imageColor
        self.buttonColor = buttonColor
        self.padding = padding
        self.cornerRadius = cornerRadius
        self.action = action
    }
    var body: some View{
        Button(action: {
            action()
            
        }) {
            image.foregroundColor(imageColor)
        }
        .padding(.all,padding)
        .background(buttonColor)
        .clipShape(.rect(cornerRadius:cornerRadius, style: .circular))
        .shadow(color: Color.black.opacity(0.5), radius: 3, x: 0, y:3)
    }
}
