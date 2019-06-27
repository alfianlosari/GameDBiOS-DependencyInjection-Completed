//
//  MockGameService.swift
//  DependencyInjectionTests
//
//  Created by Alfian Losari on 28/06/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

@testable import DependencyInjection
import Foundation

class MockGameService: GameService {
   
    var isFetchPopularGamesInvoked = false
    var isFetchGameInvoked = false
    
    static let stubGames = [
        Game(id: 1, name: "Suikoden 7", storyline: "test", summary: "test", releaseDate: Date(), popularity: 8.0, rating: 8.0, coverURLString: "test", screenshotURLsString: ["test"], genres: ["test"], company: "test"),
        Game(id: 2, name: "Kingdom Hearts 4", storyline: "test", summary: "test", releaseDate: Date(), popularity: 8.0, rating: 8.0, coverURLString: "test", screenshotURLsString: ["test"], genres: ["test"], company: "test"),
    ]
    
    
    func fetchPopularGames(for platform: Platform, completion: @escaping (Result<[Game], Error>) -> Void) {
        isFetchPopularGamesInvoked = true
        completion(.success(MockGameService.stubGames))
    }
    
    func fetchGame(id: Int, completion: @escaping (Result<Game, Error>) -> Void) {
        isFetchGameInvoked = true
        completion(.success(MockGameService.stubGames[0]))
    }
    
}
