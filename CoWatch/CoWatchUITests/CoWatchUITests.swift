//
//  CoWatchUITests.swift
//  CoWatchUITests
//
//  Created by IM Student on 2025-11-23.
//

import XCTest

final class CoWatchUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testFullHostSessionFlow() throws {
        let app = XCUIApplication()
        app.launch()

        // Welcome screen
        XCTAssertTrue(app.staticTexts["CoWatch"].waitForExistence(timeout: 5))

        // Move focus to "Host Session" and press select
        let hostButton = app.buttons["Host Session"]
        XCTAssertTrue(hostButton.waitForExistence(timeout: 5))
        hostButton.tap()

        // Content browser - select first content card
        let chooseLabel = app.staticTexts["Choose something to watch"]
        XCTAssertTrue(chooseLabel.waitForExistence(timeout: 5))

        let firstCard = app.staticTexts.element(boundBy: 0)
        XCTAssertTrue(firstCard.waitForExistence(timeout: 5))
        firstCard.tap()

        // Lobby
        XCTAssertTrue(app.staticTexts["Lobby"].waitForExistence(timeout: 5))
        let startPlayback = app.buttons["Start Playback"]
        XCTAssertTrue(startPlayback.waitForExistence(timeout: 5))
        startPlayback.tap()

        // Playback
        let endAndLeaderboard = app.buttons["End & Leaderboard"]
        XCTAssertTrue(endAndLeaderboard.waitForExistence(timeout: 10))

        // Wait briefly for potential quiz overlay, then end session
        sleep(3)
        endAndLeaderboard.tap()

        // Leaderboard
        XCTAssertTrue(app.staticTexts["Leaderboard"].waitForExistence(timeout: 5))
    }
}
