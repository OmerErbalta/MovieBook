//
//  MovieDetailViewModel.swift
//  LoodosProject
//
//  Created by OmerErbalta on 19.05.2024.
//

import Foundation
import FirebaseAnalytics

class MovieDetailViewModel:ObservableObject{
    
    
    func logMovieDetails(movie: Movie) {
           Analytics.logEvent("movie_details_view", parameters: [
               "title": movie.title ?? "-",
               "imdbID": movie.imdbID ?? "-",
               "year": movie.year ?? "-",
               "metascore": movie.metascore ?? "-"
           ])
       }
}
