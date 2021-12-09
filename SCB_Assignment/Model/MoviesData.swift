//
//  MoviesData.swift
//  SCB_Assignment
//
//  Created by Naresh Muthuluri on 03/12/21.
//

import Foundation

struct MoviesData: Codable {
    let movies: [Movies]?
    let totalResults, response: String?
    
    enum CodingKeys: String, CodingKey {
        case movies = "Search"
        case totalResults
        case response = "Response"
    }
}

struct Movies: Codable {
    let title, year, imdbID: String?
    let type: String?
    let poster: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
