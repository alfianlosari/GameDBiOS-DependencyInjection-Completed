//
//  GameListViewController.swift
//  DependencyInjection
//
//  Created by Alfian Losari on 27/06/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import UIKit

class GameListViewController: UICollectionViewController {
    
    var games = [Game]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let gameService: GameService
    private let platform: Platform
    
    init(gameService: GameService, platform: Platform) {
        self.gameService = gameService
        self.platform = platform
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadGame()
    }
    
    private func loadGame() {
        gameService.fetchPopularGames(for: platform) { (result) in
            switch result {
            case .success(let games):
                self.games = games
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: "GameThumbnailCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let imageWidth: CGFloat = 150
        let ratioMultiplier = 200.0 / imageWidth
        let containerWidth = view.bounds.width
        
        let itemCount = containerWidth / imageWidth
        let itemWidth = imageWidth * (itemCount / ceil(itemCount))
        let itemHeight = ratioMultiplier * itemWidth

        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GameThumbnailCell
        let game = games[indexPath.item]
        cell.configure(game.coverURL)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let game = games[indexPath.item]
        let gameDetailVC = GameDetailViewController(id: game.id, gameService: gameService)
        navigationController?.pushViewController(gameDetailVC, animated: true)
    }

}
