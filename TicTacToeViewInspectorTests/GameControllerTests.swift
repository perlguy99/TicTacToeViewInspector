//
//  GameControllerTests.swift
//  GameControllerTests
//
//  Created by Brent Michalski on 8/24/24.
//

import XCTest
@testable import TicTacToeViewInspector

final class GameControllerTests: XCTestCase {

    func testGameControllerExists() throws {
        XCTAssertNoThrow(GameController())
    }

    func testInitialStateOfCurrentTurn() throws {
        let sut = GameController()
        XCTAssertEqual(sut.currentTurn, "X")
    }
}
