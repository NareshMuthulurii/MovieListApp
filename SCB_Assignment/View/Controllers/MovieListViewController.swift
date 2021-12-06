//
//  MoviesListViewController.swift
//  SCB_Assignment
//
//  Created by Naresh Muthuluri on 03/12/21.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var searching = false
    let searchController = UISearchController(searchResultsController: nil)
    private var moviesViewModel = MoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        moviesViewModel.configureSearchController(searchController: searchController)
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
        self.navigationController?.navigationBar.prefersLargeTitles = true
        definesPresentationContext = true
        fetchMoviesData()
    }
    
    func fetchMoviesData() {
        moviesViewModel.fetchMoviesData { [weak self] in
            self?.collectionView.dataSource = self
            self?.collectionView.reloadData()
        }
    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesViewModel.numberOfRowsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesListCell", for: indexPath) as? MovieListCollectionViewCell else { fatalError("Unable to dequeue Cell.") }
        let movie = moviesViewModel.cellForItemAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesListCell", for: indexPath) as! MovieListCollectionViewCell
        let movie = moviesViewModel.cellForItemAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        if let movieDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController {
            movieDetailsVC.imdbId = movie.imdbID
            if let navigator = navigationController {
                navigator.pushViewController(movieDetailsVC, animated: true)
            }
        }
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((collectionView.bounds.width / 2) - 8), height: 300)
    }
}

extension MovieListViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        moviesViewModel.updatingSearchResults(for: searchController)
        collectionView.reloadData()
    }
    
    func search(searchBar: UISearchBar) {
        moviesViewModel.searchBarCancelButtonClicked(searchBar)
        collectionView.reloadData()
    }
}
