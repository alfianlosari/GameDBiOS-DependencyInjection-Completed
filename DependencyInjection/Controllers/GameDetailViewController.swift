//
//  GameDetailViewController.swift
//  DependencyInjection
//
//  Created by Alfian Losari on 27/06/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import UIKit

fileprivate enum Cell {
    case backdropCover(URL)
    case metadata(Game)
    case text(String)
    case imageGrid([URL])
    
}

class GameDetailViewController: UITableViewController {
    
    private let id: Int
    private let gameService: GameService
    
    init(id: Int, gameService: GameService) {
        self.id = id
        self.gameService = gameService
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate var sections = [(title: String?, rows: [Cell])]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        loadGame()
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(GameBackdropTableViewCell.nib, forCellReuseIdentifier: "BackdropCell")
        tableView.register(GameDetailTableViewCell.nib, forCellReuseIdentifier: "DetailCell")
        tableView.register(UINib(nibName: "TableGridTableViewCell", bundle: nil), forCellReuseIdentifier: "GridCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TextCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    private func loadGame() {
        gameService.fetchGame(id: id) {[weak self] (result) in
            switch result {
            case .success(let game):
                self?.buildSections(with: game)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    
    private func buildSections(with game: Game) {
        title = game.name
        
        var sections: [(String?, [Cell])] = []
        if let url = game.coverURL {
            sections.append((nil, [.backdropCover(url)]))
        }
        sections.append((nil, [.metadata(game)]))
        
        if (!game.storyline.isEmpty) {
            sections.append(("Storyline", [.text(game.storyline)]))
        }
        
        if (!game.screenshootURLs.isEmpty) {
            sections.append(("Images", [.imageGrid(game.screenshootURLs)]))
        }
        self.sections = sections
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = sections[indexPath.section].rows[indexPath.row]
        
        switch cellType {
        case .backdropCover(let url):
            let cell = tableView.dequeueReusableCell(withIdentifier: "BackdropCell", for: indexPath) as! GameBackdropTableViewCell
            cell.imageURL = url
            return cell
            
        case .metadata(let game):
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! GameDetailTableViewCell
            cell.configure(game)
            return cell
            
        case .text(let text):
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath)
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = text
            return cell
            
        case .imageGrid(let urls):
            let cell = tableView.dequeueReusableCell(withIdentifier: "GridCell", for: indexPath) as! TableGridTableViewCell
            cell.screenshotURLs = urls
            cell.frame = tableView.bounds
            cell.layoutIfNeeded()
            cell.collectionView.reloadData()
            cell.collectionViewHeightConstraint.constant = cell.collectionView.collectionViewLayout.collectionViewContentSize.height
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
}
