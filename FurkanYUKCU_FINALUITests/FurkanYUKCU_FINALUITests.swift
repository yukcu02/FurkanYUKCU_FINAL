//
//  FurkanYUKCU_FINALUITests.swift
//  FurkanYUKCU_FINALUITests
//
//  Created by Furkan Yükcü on 8.06.2023.
//

import XCTest

final class FurkanYUKCU_FINALUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        func testTableViewExists() {
            let app = XCUIApplication()
            app.launch()

            XCTAssertTrue(app.tables["tableView"].exists)
        }
        func testSearchBarExists() {
            let app = XCUIApplication()
            app.launch()

            XCTAssertTrue(app.searchFields["searchBar"].exists)
        }
        func testCellExists() {
            let app = XCUIApplication()
            app.launch()

            let tableView = app.tables["tableView"]
            XCTAssertTrue(tableView.cells.element(boundBy: 0).exists)
        }
        func testCellTappingNavigatesToDetail() {
            let app = XCUIApplication()
            app.launch()

            let tableView = app.tables["tableView"]
            let cell = tableView.cells.element(boundBy: 0)
            cell.tap()

            XCTAssertTrue(app.navigationBars["DetailView"].exists)
        }
        func testPlayButtonPlaysAudio() {
            let app = XCUIApplication()
            app.launch()

            let tableView = app.tables["tableView"]
            let cell = tableView.cells.element(boundBy: 0)
            let playButton = cell.buttons["playButton"]
            playButton.tap()

            // Add assertions to check if audio is playing
        }
        func testTrackNameLabelExists() {
            let app = XCUIApplication()
            app.launch()

            let tableView = app.tables["tableView"]
            let cell = tableView.cells.element(boundBy: 0)
            let trackNameLabel = cell.staticTexts["trackName"]
            
            XCTAssertTrue(trackNameLabel.exists)
        }
        func testArtistNameLabelExists() {
            let app = XCUIApplication()
            app.launch()

            let tableView = app.tables["tableView"]
            let cell = tableView.cells.element(boundBy: 0)
            let artistNameLabel = cell.staticTexts["artistName"]
            
            XCTAssertTrue(artistNameLabel.exists)
        }
        func testCollectionNameLabelExists() {
            let app = XCUIApplication()
            app.launch()

            let tableView = app.tables["tableView"]
            let cell = tableView.cells.element(boundBy: 0)
            let collectionNameLabel = cell.staticTexts["collectionName"]
            
            XCTAssertTrue(collectionNameLabel.exists)
        }
        func testMusicImageExists() {
            let app = XCUIApplication()
            app.launch()

            let tableView = app.tables["tableView"]
            let cell = tableView.cells.element(boundBy: 0)
            let musicImage = cell.images["musicImg"]
            
            XCTAssertTrue(musicImage.exists)
        }
        func testSearchDisplaysResults() {
            let app = XCUIApplication()
            app.launch()

            let searchBar = app.searchFields["searchBar"]
            searchBar.tap()
            searchBar.typeText("example")

            let tableView = app.tables["tableView"]
            XCTAssertTrue(tableView.cells.count > 0)
        }
        func testMusicListDisplayed() {
            let app = XCUIApplication()
            app.launch()

            XCTAssertTrue(app.tables["musicTableView"].exists)

            XCTAssertTrue(app.tables.cells.count > 0)
        }    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
