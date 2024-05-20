//
//  MovieCard.swift
//  LoodosProject
//
//  Created by OmerErbalta on 18.05.2024.
//

import SwiftUI

struct MovieCard: View {
    var namespace: Namespace.ID
    var movie: Movie?
    @Binding var selectedMovie: Movie?
    var isSource:Bool
    var body: some View {
        if let movie = movie {
            cardContent(for: movie)
                .onTapGesture {
                    selectMovie(movie)
                    
                }
        }
    }

    // Kartın içeriğini oluşturan fonksiyon
    @ViewBuilder
    private func cardContent(for movie: Movie) -> some View {
        VStack {
            Spacer()
            movieTitle(movie.title)
        }
        .matchedGeometryEffect(id: "\(String(describing: movie.imdbID))card", in: namespace,isSource: isSource)
        .frame(maxWidth: .infinity)
        .frame(height: Const.height * 0.4)
        .background(posterImage(movie.poster))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .circular))
        .shadow(color: Color.black.opacity(0.5), radius: 3, x: 0, y: 3)
        .padding(.vertical, 3)
    }

    // Film başlığını oluşturan fonksiyon
    private func movieTitle(_ title: String?) -> some View {
        Text(title ?? "")
            .font(.title2)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .matchedGeometryEffect(id: "\(String(describing: movie?.imdbID))title", in: namespace,isSource: isSource)
            .padding(.vertical, 10)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
            )
            .padding(.bottom, 20)
            .padding(.horizontal, 20)
    }

    // Poster görüntüsünü oluşturan fonksiyon
    private func posterImage(_ poster: String?) -> some View {
        PosterImage(deminsion: .forDetailView, poster: poster ?? "")
            .matchedGeometryEffect(id: "\(String(describing: movie?.imdbID))posterImage", in: namespace,isSource: isSource)
    }

    // Film seçildiğinde çağrılan fonksiyon
    private func selectMovie(_ movie: Movie) {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
            selectedMovie = movie
        }
    }
}

