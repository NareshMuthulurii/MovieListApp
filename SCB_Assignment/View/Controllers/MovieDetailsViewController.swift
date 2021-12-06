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
        guard let posterImageURL = URL(string: movieDetails.poster) else { return }
        self.poster.loadImage(fromURL: posterImageURL, placeHolderImage: "placeholder")
        self.movieTitle.text = movieDetails.title
        self.year.text = "Year: \(movieDetails.year)"
        self.categories.text = "Genre : \n \(movieDetails.genre)"
        self.duration.text = "Duration : \n \(movieDetails.runtime)"
        self.rating.text = "Rating: \(movieDetails.imdbRating)"
        self.synopsis.text = "Description: \n\(movieDetails.plot)"
        self.director.text = "Director: \(movieDetails.director)"
        self.writer.text =   "Writer: \(movieDetails.writer)"
        self.actor.text =    "Actors: \(movieDetails.actors)"
    }
    
}
