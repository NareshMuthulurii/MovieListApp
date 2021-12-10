//
//  ApiService.swift
//  SCB_Assignment
//
//  Created by Naresh Muthuluri on 03/12/21.
//

import Foundation

class ApiService {
    
    private var dataTask: URLSessionDataTask?
    
    func apiCall<T: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
    
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
        
        var queryItems = [URLQueryItem(name: "apikey", value: URLConstants.apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            print("invalid endpoint")
            return
        }
        
        dataTask = URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
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
                print(error.localizedDescription)
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
}
