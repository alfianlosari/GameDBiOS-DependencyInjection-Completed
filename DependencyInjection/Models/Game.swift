//
//  Game.swift
//  DependencyInjection
//
//  Created by Alfian Losari on 27/06/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import Foundation

struct Game {
    
    let id: Int
    let name: String
    let storyline: String
    let summary: String
    
    let releaseDate: Date
    let popularity: Double
    let rating: Double
    let coverURLString: String
    let screenshotURLsString: [String]
    let genres: [String]
    let company: String
    
    var coverURL: URL? {
        return URL(string: coverURLString)
    }
    
    var genreText: String {
        return genres.joined(separator: ",")
    }
    
    var screenshootURLs: [URL] {
        return screenshotURLsString.compactMap { URL(string: $0) }
    }
    
}
