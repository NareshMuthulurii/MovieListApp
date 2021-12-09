//
//  MovieDetailsViewController.swift
//  SCB_Assignment
//
//  Created by Naresh Muthuluri on 04/12/21.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var poster: LazyImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var categories: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var synopsis: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var writer: UILabel!
    @IBOutlet weak var actor: UILabel!
    
    var imdbId: String?
    private var moviesDetailsViewModel = MovieDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovieDetails()
    }
    
    // fetch Movie Details
    func fetchMovieDetails() {
        guard let id = imdbId else { return }
        moviesDetailsViewModel.fetchMovieDetailsData(id: id, completion: { [weak self] in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        })
    }
    
    func updateUI() {
        guard let movieDetails = moviesDetailsViewModel.movieDetails else { return }
        guard let posterImageURL = URL(string: movieDetails.poster ?? "") else { return }
        self.poster.loadImage(fromURL: posterImageURL, placeHolderImage: Constants.imagePlaceholder)
        self.movieTitle.text = movieDetails.title
        self.year.text = Constants.year + (movieDetails.year ?? "")
        self.categories.text = Constants.gener + (movieDetails.genre ?? "")
        self.duration.text = Constants.duration + (movieDetails.runtime ?? "")
        self.rating.text = Constants.rating + (movieDetails.imdbRating ?? "")
        self.synopsis.text = Constants.synopsis + (movieDetails.plot ?? "")
        self.director.text = Constants.director + (movieDetails.director ?? "")
        self.writer.text =   Constants.writer + (movieDetails.writer ?? "")
        self.actor.text =    Constants.actors + (movieDetails.actors ?? "")
    }
    
}
