//
//  RequestService.swift
//  SCB_Assignment
//
//  Created by Naresh Muthuluri on 09/12/21.
//

import Foundation

class RequestService: ApiService {
    func getMoviesData(completion: @escaping (Result<MoviesData, Error>) -> Void) {
        let moviesURL = Constants.moviesUrl
        guard let url = URL(string: moviesURL) else {return}
        apiCall(url: url, completion: completion)
    }
    
    func getMovieDetailsData(id: String, completion: @escaping (Result<MovieDetailsData, Error>) -> Void) {
        let moviesDetailsURL = "\(Constants.movieDetailsUrl)\(id)"
        print(moviesDetailsURL)
        guard let url = URL(string: moviesDetailsURL) else {return}
        apiCall(url: url, completion: completion)
    }
}

