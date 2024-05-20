//
//  HomePageViewModel.swift
//  LoodosProject
//
//  Created by OmerErbalta on 18.05.2024.
//

import Foundation
import Combine

class HomePageViewModel: ObservableObject {
    @Published var movieList: MovieList?
    @Published var error: String?
    @Published var selectedMovie: Movie?
    @Published var startedSearch: Bool?
    @Published var searchText: String = "" {
        didSet {
            updateSearchButtonVisibility()
        }
    }
    @Published var isSearchButtonVisible: Bool = false

    private let service: MovieServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(service: MovieServiceProtocol = MovieService()) {
        self.service = service
    }

    func updateSearchButtonVisibility() {
        isSearchButtonVisible = !searchText.isEmpty
    }

    func searchMovie(query: String) {
        clearResults()
        service.searchMovie(query: query) { [weak self] result in
            switch result {
            case .success(let movieList):
                self?.handleSearchSuccess(movieList)
            case .failure(let error):
                self?.handleSearchError(error)
            }
        }
    }
    
    func fetchMovieById(id: String, completion: @escaping (Result<Movie, Error>) -> Void) {
        service.searchMoviesById(id: id) { result in
            switch result {
            case .success(let movie):
                completion(.success(movie))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }



    private func clearResults() {
        error = nil
        movieList = nil
    }

    private func handleSearchSuccess(_ movieList: MovieList) {
        self.movieList = movieList
        self.movieList?.search = []
        for i in 0..<movieList.search!.count{
            fetchMovieById(id:movieList.search![i].imdbID! ) { result in
                switch result {
                case .success(let movie):
                    self.movieList?.search?.append(movie)
                case .failure(let error):
                    print(error)
                }
            }
        }
      
       
       
    }

    private func handleSearchError(_ error: Error) {
        print("Error searching movie: \(error)")
        self.error = error.localizedDescription
    }
}


