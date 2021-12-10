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
        setupSearchBar()
        fetchMoviesData()
    }
    
    fileprivate func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        moviesViewModel.configureSearchController(searchController: searchController)
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
        self.navigationController?.navigationBar.prefersLargeTitles = true
        definesPresentationContext = true
    }
    
    // Fetch Movies
    func fetchMoviesData() {
        moviesViewModel.fetchMoviesData(movieType: "marvel", completion: { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        })
    }
}

// MARK: - CollectionView Delegate & DataSource
extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesViewModel.numberOfRowsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.movieListCell, for: indexPath) as? MovieListCollectionViewCell else { fatalError(Constants.dequeCellFatalError) }
        cell.setCellWithValuesOf(moviesViewModel.cellForItemAt(indexPath: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.movieListCell, for: indexPath) as! MovieListCollectionViewCell
        cell.setCellWithValuesOf(moviesViewModel.cellForItemAt(indexPath: indexPath))
        if let movieDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.detailsViewController) as? MovieDetailsViewController {
            movieDetailsVC.imdbId = moviesViewModel.cellForItemAt(indexPath: indexPath).imdbID
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

// MARK: - SearchBarController Delegate
extension MovieListViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        moviesViewModel.updatingSearchResults(for: searchController)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func search(searchBar: UISearchBar) {
        moviesViewModel.searchBarCancelButtonClicked(searchBar)
        collectionView.reloadData()
    }
}
