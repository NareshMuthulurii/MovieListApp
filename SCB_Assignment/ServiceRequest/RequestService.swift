//
//  RequestService.swift
//  SCB_Assignment
//
//  Created by Naresh Muthuluri on 09/12/21.
//

import Foundation

class RequestService: ApiService {
    func getMoviesData(type: String, completion: @escaping (Result<MoviesData, Error>) -> Void) {
        let basURL = URLConstants.baseURL
        guard let url = URL(string: basURL) else {return}
        apiCall(url: url, params: ["s" : type,],  completion: completion)
    }
    
    func getMovieDetailsData(id: String, completion: @escaping (Result<MovieDetailsData, Error>) -> Void) {
        let moviesDetailsURL = URLConstants.baseURL
        print(moviesDetailsURL)
        guard let url = URL(string: moviesDetailsURL) else {return}
        apiCall(url: url, params: ["i" : id], completion: completion)
    }
}

