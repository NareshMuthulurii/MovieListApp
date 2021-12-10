//
//  MovieDetailsViewModel.swift
//  SCB_Assignment
//
//  Created by Naresh Muthuluri on 05/12/21.
//

import Foundation

class MovieDetailsViewModel: NSObject {
    
    private var apiService: RequestService!
    var movieDetails: MovieDetailsData?
    
    override init() {
        super.init()
        self.apiService = RequestService()
    }
    
    func fetchMovieDetailsData(id: String, completion: @escaping () -> ()) {
        apiService.getMovieDetailsData(id: id, completion: { [weak self] (result) in
            switch result {
            case .success(let details):
                self?.movieDetails = details
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        })
    }
}
