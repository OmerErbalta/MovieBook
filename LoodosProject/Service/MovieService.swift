import Foundation
import Alamofire

protocol MovieServiceProtocol {
    func searchMovie(query: String, completion: @escaping (Result<MovieList, Error>) -> Void)
    func searchMoviesById(id: String, completion: @escaping (Result<Movie, Error>) -> Void)
}

class MovieService: MovieServiceProtocol {
    static let shared = MovieService()
    
    func searchMovie(query: String, completion: @escaping (Result<MovieList, Error>) -> Void) {
        let parameters = [
            "apikey": Keys.apiKey,
            "s": query
        ]
        
        AF.request(Keys.apiBaseURL, parameters: parameters)
            .responseDecodable(of: MovieList.self) { response in
                self.handleResponse(response, completion: completion)
            }
    }
    
    func searchMoviesById(id: String, completion: @escaping (Result<Movie, Error>) -> Void) {
        let parameters = [
            "apikey": Keys.apiKey,
            "i": id
        ]
        
        AF.request(Keys.apiBaseURL, parameters: parameters)
            .responseDecodable(of: Movie.self) { response in
                self.handleResponse(response, completion: completion)
            }
    }
    
    private func handleResponse<T: Decodable>(_ response: AFDataResponse<T>, completion: @escaping (Result<T, Error>) -> Void) {
        if let error = response.error {
            if let apiError = handleAPIError(error: error) {
                completion(.failure(apiError))
            } else {
                completion(.failure(error))
            }
            return
        }
        
        if let value = response.value {
            if let movieList = value as? MovieList, movieList.response == false {
                let errorMessage = movieList.error ?? "Unknown Error"
                completion(.failure(NSError(domain: "Error", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
            } else if let movie = value as? Movie, movie.response == false {
                let errorMessage = movie.error ?? "Unknown Error"
                completion(.failure(NSError(domain: "Error", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
            } else {
                completion(.success(value))
            }
        }
    }
    
    private func handleAPIError(error: AFError) -> Error? {
        guard let statusCode = error.responseCode else {
            return NSError(domain: "UnknownError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred"])
        }
        
        let errorMessage: String
        switch statusCode {
        case 400:
            errorMessage = "Bad request"
        case 401:
            errorMessage = "Unauthorized"
        case 403:
            errorMessage = "Forbidden"
        case 404:
            errorMessage = "Not found"
        default:
            errorMessage = "HTTP error occurred"
        }
        
        return NSError(domain: "\(statusCode)Error", code: statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])
    }
}
