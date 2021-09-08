//
//  HeroesViewControllerTests.swift
//  MarvelTests
//
//  Created by Alejandro Perea Navarrete on 7/9/21.
//

import XCTest
@testable import Marvel

class HeroesViewControllerTests: XCTestCase {
    
    var viewController: HeroesViewController!
    
    override func setUpWithError() throws {
        let characterData = try CharacterMock().getCharacterMock()
        
        viewController = Assembler.shared.resolve()
        viewController.loadView()
        viewController.viewDidLoad()
        viewController.presenter?.view?.showHeroes(heroes: characterData.data.heroes)
    }

    override func tearDownWithError() throws {
        viewController = nil
    }
    
    func testHasATableView() {
        XCTAssertNotNil(viewController.tableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(viewController.tableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(viewController.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.tableView(_:didSelectRowAt:))))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(viewController.tableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(viewController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.tableView(_:cellForRowAt:))))
    }

    func testTableViewCellHasReuseIdentifier() {
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? HeroCell
        let reuseIdentifier = cell?.reuseIdentifier
        let expectedReuseIdentifier = "HeroCell"
        XCTAssertEqual(reuseIdentifier, expectedReuseIdentifier)
    }
    
    func testHeroCellUI() {
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? HeroCell
        XCTAssertEqual(cell?.heroView.nameLabel.text, "3-D Man")
        XCTAssertEqual(cell?.heroView.nameLabel.textColor, Colors.textColor)
        XCTAssertEqual(cell?.heroView.backgroundColor, Colors.backgroundColor)
    }
    
    func testNavigationBarImage() {
        guard let imageView = viewController.navigationItem.titleView as? UIImageView else {
            XCTFail("Expected imageview in at this point")
            return
        }
        XCTAssertEqual(imageView.image, UIImage(named: "marvel"))
    }
    
    func testHasSearchController() {
        XCTAssertNotNil(viewController.navigationItem.searchController)
    }
    
    func testHasRefreshControl() {
        XCTAssertNotNil(viewController.tableView.refreshControl)
    }
}
