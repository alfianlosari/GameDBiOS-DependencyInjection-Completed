//
//  MovieDetailTableViewCell.swift
//  MovieKit
//
//  Created by Alfian Losari on 11/25/18.
//  Copyright © 2018 Alfian Losari. All rights reserved.
//

import UIKit

public class GameDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    
    public static var nib: UINib {
        return UINib(nibName: "GameDetailTableViewCell", bundle: Bundle(for: GameDetailTableViewCell.self))
    }
    
    public static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        return dateFormatter
    }()
    
    func configure(_ game: Game) {
        overviewLabel.text = game.summary
        yearLabel.text = GameDetailTableViewCell.dateFormatter.string(from: game.releaseDate)
        
        if game.rating > 0 {
            ratingLabel.text = String(game.rating)
ratingLabel.isHidden = false
        } else {
            ratingLabel.isHidden = true
        }
        
        genreLabel.text = game.genreText
        castLabel.text = game.company
    }
    
//    public var movie: Movie? {
//        didSet {
//            guard let movie = movie else {
//                return
//            }
//
//            taglineLabel.text = movie.tagline
//            overviewLabel.text = movie.overview
//            yearLabel.text = MovieDetailTableViewCell.dateFormatter.string(from: movie.releaseDate)
//            if movie.voteCount == 0 {
//                ratingLabel.isHidden = true
//            } else {
//                ratingLabel.isHidden = false
//                ratingLabel.text = movie.voteAveragePercentText
//            }
//
//            adultLabel.isHidden = !movie.adult
//
//            durationLabel.text = "\(movie.runtime ?? 0) mins"
//            if let genres = movie.genres, genres.count > 0 {
//                genreLabel.isHidden = false
//                genreLabel.text = genres.map { $0.name }.joined(separator: ", ")
//            } else {
//                genreLabel.isHidden = true
//            }
//
//            if let casts = movie.credits?.cast, casts.count > 0 {
//                castLabel.isHidden = false
//                castLabel.text = "Cast: \(casts.prefix(upTo: 3).map { $0.name }.joined(separator: ", "))"
//            } else {
//                castLabel.isHidden = true
//            }
//
//            if let director = movie.credits?.crew.first(where: {$0.job == "Director"}) {
//                crewLabel.isHidden = false
//                crewLabel.text = "Director: \(director.name)"
//            } else {
//                crewLabel.isHidden = true
//            }
//
//        }
//    }
//
}
