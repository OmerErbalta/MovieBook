// MovieDetailView.swift
import SwiftUI

struct MovieDetailView: View {
    var namespace: Namespace.ID
    @Binding var selectedMovie: Movie?
    @StateObject private var viewModel = MovieDetailViewModel()
    var isSource:Bool
    var body: some View {
        if let movie = selectedMovie {
            ZStack {
                ScrollView {
                    VStack {
                        // Film detayları
                        movieDetailsView(movie: movie)
                            .padding(.horizontal, Const.width * 0.05)
                            .frame(maxWidth: .infinity)
                            .padding(.top, Const.height * 0.4)
                        // İlgili insanlar
                        HumanDetailCardView(title: "Actors",content: movie.actors!)
                        HumanDetailCardView(title: "Writer",content: movie.writer!)
                        HumanDetailCardView(title: "Director",content: movie.director!)
                        Spacer()
                    }
                }
                .background(posterImageBackground(movie: movie))
                // Kapatma butonu
                closeButton()
            }
            .onAppear{
                viewModel.logMovieDetails(movie: movie)
            }
            .background(
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
            .ignoresSafeArea(.all)
            
        }}
    
    // Film detaylarını gösteren view
    private func movieDetailsView(movie: Movie) -> some View {
        VStack {
            Text(movie.title ?? "")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundStyle(.yellow)
                .frame(maxWidth: .infinity)
                .matchedGeometryEffect(id: "\(String(describing: movie.imdbID))title", in: namespace,isSource: isSource)
                .padding(.vertical)
            MovieDetailText(header: "IMDB", value: (movie.metascore! != "N/A" ? (movie.metascore! + " - ") : "")  + movie.imdbRating! )
            MovieDetailText(header: "Since", value: movie.year ?? "")
            MovieDetailText(header: "Run time", value: movie.runtime ?? "")
            MovieDetailText(header: "Income", value: movie.boxOffice != "N/A" && movie.boxOffice != nil   ? movie.boxOffice! : "?")
        }
        .matchedGeometryEffect(id: "\(String(describing: movie.imdbID))card", in: namespace,isSource: isSource)
        .background(
            Rectangle()
                .fill(.ultraThinMaterial)
                .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
        )
    }
    
    // Arka planda film afişini gösteren view
    private func posterImageBackground(movie: Movie) -> some View {
        VStack(alignment: .center) {
            VStack {
                PosterImage(deminsion: .forDetailView, poster: movie.poster ?? "")
                    .matchedGeometryEffect(id: "\(String(describing: movie.imdbID))posterImage", in: namespace,isSource: isSource)
            }
            .padding(.top, Const.height * 0.1)
            Spacer()
        }
    }
    
    // Kapatma butonu
    private func closeButton() -> some View {
        Button(action: {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                self.selectedMovie = nil
            }
        }) {
            Image(systemName: "xmark")
                .font(.title3.weight(.bold))
                .foregroundColor(.white)
                .padding(7)
                .background(.ultraThinMaterial, in: .circle)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(.top, 50)
        .padding(8)
    }
}

