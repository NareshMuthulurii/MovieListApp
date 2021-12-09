//
//  MoviesViewModel.swift
//  SCB_Assignment
//
//  Created by Naresh Muthuluri on 04/12/21.
//

import Foundation
import UIKit

class MoviesViewModel: NSObject {
    
    private var apiService: RequestService!
    var movies: [Movies]!
    var searching = false
    var searchedMovie = [Movies]()
    
    override init() {
        super.init()
        self.apiService = RequestService()
        self.movies = [Movies]()
    }
    
    func configureSearchController(searchController: UISearchController) {
        searchController.loadViewIfNeeded()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        searchController.searchBar.placeholder = "Search Movies"
    }
    
    func updatingSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty {
            searching = true
            searchedMovie.removeAll()
            for movie in movies {
                guard let title = movie.title else { return }
                if title.lowercased().contains(searchText.lowercased()) {
                    searchedMovie.append(movie)
                }
            }
        } else {
            searching = false
            searchedMovie.removeAll()
            searchedMovie = movies
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchedMovie.removeAll()
    }
    
    func fetchMoviesData(completion: @escaping () -> ()) {
        apiService.getMoviesData{ [weak self] (result) in
            switch result {
            case .success(let listOf):
                self?.movies = listOf.movies ?? []
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if searching {
            return searchedMovie.count
        } else {
            return movies.count
        }
    }
    
    func cellForItemAt(indexPath: IndexPath) -> Movies {
        if searching {
            return searchedMovie[indexPath.row]
        } else {
            return movies[indexPath.row]
        }
    }
    
    func didSelectItem(imdbId: String, indexPath: IndexPath) -> Movies {
        if searching {
            return searchedMovie[indexPath.row]
        } else {
            return movies[indexPath.row]
        }
    }
}
