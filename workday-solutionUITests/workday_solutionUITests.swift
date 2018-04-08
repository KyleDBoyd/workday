//
//  workday_solutionUITests.swift
//  workday-solutionUITests
//
//  Created by Clinton Buie on 4/6/18.
//  Copyright © 2018 AmateMint. All rights reserved.
//

import XCTest

class workday_solutionUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFirstLoadUI() {
        
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        let exists = NSPredicate(format: "exists == 1")
        let element = app.collectionViews.children(matching: .cell).element(boundBy: 1).children(matching: .other).element(boundBy: 1)
        expectation(for: exists, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: 90, handler: nil)
        
        element.swipeUp()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.swipeDown()

    }
    
    func testSecondLoadUI() {
        
        let app = XCUIApplication()
        let element = app.collectionViews.children(matching: .cell).element(boundBy: 1).children(matching: .other).element(boundBy: 1)
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: 90, handler: nil)
        element.tap()
        
        let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element2.tap()
        element.swipeUp()
    }
    
}
