//
//  AppRouterTest.swift
//  MarvelTests
//
//  Created by Alejandro Perea Navarrete on 6/9/21.
//

import XCTest
@testable import Marvel

class AppRouterTest: XCTestCase {

    var window: UIWindow!
    var appRouter: AppRouter!
    
    override func setUpWithError() throws {
        window = UIWindow()
        appRouter = AppRouter(window: window)
        appRouter.showInitialViewController()
    }

    override func tearDownWithError() throws {
        window = nil
        appRouter = nil
    }

    func testModuleIsNotNil() {
        XCTAssertNotNil(window, "window is not nil")
        XCTAssertNotNil(appRouter, "router is not nil")
    }
    
    func testRootViewControllerIsNotNil() {
        XCTAssertNotNil(window.rootViewController, "rootViewController is not nil")
    }
    
    func testRootViewControllerClass() {
        guard let rootViewController = window.rootViewController else {
            XCTFail("Expected root controller in at this point")
            return
        }
        XCTAssertTrue(type(of: rootViewController) == UINavigationController.self, "Root controller is type of UINavigationController")
    }
    
    func testInitialViewControllerClass() {
        guard let initialViewController = window.rootViewController?.children.first else {
            XCTFail("Expected initial controller in at this point")
            return
        }
        XCTAssertTrue(type(of: initialViewController) == HeroesViewController.self, "Initial controller is type of HeroesViewController")
    }
    
    func testUserInterfaceStyleIsDark() {
        XCTAssertTrue(window.traitCollection.userInterfaceStyle == .dark, "user interface style is dark")
    }
    

}
