//
//  MovieListCollectionViewCell.swift
//  SCB_Assignment
//
//  Created by Naresh Muthuluri on 04/12/21.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePoster: LazyImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    private var urlString: String = ""
    
    func setCellWithValuesOf(_ movie: Movies) {
        updateUI(id: movie.imdbID, title: movie.title, poster: movie.poster)
    }
    
    private func updateUI(id: String?, title: String?, poster: String?) {
        self.movieTitle.text = title
        guard let posterString = poster else {return}
        urlString = posterString
        guard let posterImageURL = URL(string: urlString) else { return }
        self.moviePoster.loadImage(fromURL: posterImageURL, placeHolderImage: "placeholder")
    }
}
