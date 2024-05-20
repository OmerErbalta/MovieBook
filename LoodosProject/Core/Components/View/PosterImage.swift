//
//  PosterImage.swift
//  LoodosProject
//
//  Created by OmerErbalta on 18.05.2024.
//

import SwiftUI
import Kingfisher

struct PosterImage: View {
    let posterSize : PosterSize
    let posterUrl:String
    init(deminsion posterSize: PosterSize,poster posterUrl:String)
    {
        self.posterSize = posterSize
        self.posterUrl = posterUrl
    }
    var body: some View {
        KFImage(URL(string: posterUrl))
                .resizable()
                .frame(width: posterSize.deminsion,height: posterSize.deminsion)
                .mask(RoundedRectangle(cornerRadius: posterSize.cornerRadius, style: .continuous))
                .padding()

    }
}

enum PosterSize{
    case forCard
    case forDetailView
    var deminsion : CGFloat{
        switch self{
        case .forCard:
            return Const.width * 0.25
        case .forDetailView:
            return Const.width * 0.95
        }
    }
    var cornerRadius : CGFloat{
        switch self {
        case .forCard:
            15
        case .forDetailView:
            20
        }
    }
}
