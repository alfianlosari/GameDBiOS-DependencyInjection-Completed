//
//  GameListviewControllerTests.swift
//  DependencyInjectionTests
//
//  Created by Alfian Losari on 28/06/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import UIKit
import XCTest
@testable import DependencyInjection

class GameListViewControllerTests: XCTestCase {
    
    var sut: GameListViewController!
    var mockGameService: MockGameService!
    
    override func setUp() {
        super.setUp()
        mockGameService = MockGameService()
        sut = GameListViewController(gameService: mockGameService, platform: .ps4)
    }
    
    func testFetchGamesIsInvokedInViewDidLoad() {
        _ = sut.view
        XCTAssertTrue(mockGameService.isFetchPopularGamesInvoked)
        
    }
    
    func testFetchGamesReloadCollectionViewWithData() {
        _ = sut.view
        XCTAssertTrue(sut.collectionView.numberOfItems(inSection: 0) != 0)
    }
}
