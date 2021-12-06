//
//  ApiService.swift
//  SCB_Assignment
//
//  Created by Naresh Muthuluri on 03/12/21.
//

import Foundation

class ApiService {
    
    private var dataTask: URLSessionDataTask?
    
    func getMoviesData(completion: @escaping (Result<MoviesData, Error>) -> Void) {
        let moviesURL = "http://www.omdbapi.com/?apikey=b9bd48a6&s=Marvel&type=movie"
        guard let url = URL(string: moviesURL) else {return}
        apiCall(url: url, completion: completion)
    }
    
    func getMovieDetailsData(id: String, completion: @escaping (Result<MovieDetailsData, Error>) -> Void) {
        let moviesURL = "http://www.omdbapi.com/?apikey=b9bd48a6&i=\(id)"
        print(moviesURL)
        guard let url = URL(string: moviesURL) else {return}
        apiCall(url: url, completion: completion)
    }
    
    func apiCall<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Handle error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
}
