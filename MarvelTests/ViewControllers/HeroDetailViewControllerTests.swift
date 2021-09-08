//
//  HeroDetailViewControllerTests.swift
//  MarvelTests
//
//  Created by Alejandro Perea Navarrete on 8/9/21.
//

import XCTest
@testable import Marvel

class HeroDetailViewControllerTests: XCTestCase {
    
    var viewController: HeroDetailViewController!
    var detailHeroModel: DetailHeroModel!
    
    override func setUpWithError() throws {
        guard let hero = try CharacterMock().getCharacterMock().data.heroes.first else {
            XCTFail("Expected hero data in at this point")
            return
        }
        viewController = Assembler.shared.resolve(hero: hero)
        viewController.loadView()
        viewController.viewDidLoad()
        
        let comics = try ComicsMock().getComicsMock().data.getImagesURL
        let events = try EventsMock().getEventsMock().data.getImagesURL
        let series = try EventsMock().getEventsMock().data.getImagesURL
        
        detailHeroModel = DetailHeroModel(hero: hero, comics: comics, events: events, series: series)
        viewController.presenter?.view?.showContent(content: detailHeroModel)
    }

    override func tearDownWithError() throws {
        viewController = nil
    }

    func testHasATableView() {
        XCTAssertNotNil(viewController.tableView)
    }

    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(viewController.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.tableView(_:viewForHeaderInSection:))))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.tableView(_:heightForHeaderInSection:))))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(viewController.tableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(viewController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.numberOfSections(in:))))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.tableView(_:cellForRowAt:))))
    }
    
    func testTableViewCellHasReuseIdentifier() {
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? ListTableViewCell
        let reuseIdentifier = cell?.reuseIdentifier
        let expectedReuseIdentifier = "ListTableViewCell"
        XCTAssertEqual(reuseIdentifier, expectedReuseIdentifier)
    }
    
    func testComicsCellUI() {
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? ListTableViewCell
        XCTAssertEqual(cell?.titleLabel.text, "Comics")
        XCTAssertEqual(cell?.titleLabel.textColor, Colors.textColor)
    }
    
    func testSeriesCellUI() {
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 1)) as? ListTableViewCell
        XCTAssertEqual(cell?.titleLabel.text, "Series")
        XCTAssertEqual(cell?.titleLabel.textColor, Colors.textColor)
    }
    
    func testEventsCellUI() {
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 2)) as? ListTableViewCell
        XCTAssertEqual(cell?.titleLabel.text, "Events")
        XCTAssertEqual(cell?.titleLabel.textColor, Colors.textColor)
    }
    
    func testNavigationBar() {
        XCTAssertEqual(viewController.title, detailHeroModel.hero.name)
    }
}
