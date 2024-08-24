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
    
    func testChangeCurrentTurn() throws {
        let sut = GameController()
        sut.updateTurn()
        XCTAssertEqual(sut.currentTurn, "O")
    }
    
    func testChangeCurrentTurnTo_O_then_X() throws {
        let sut = GameController()
        sut.updateTurn()
        XCTAssertEqual(sut.currentTurn, "O")
        sut.updateTurn()
        XCTAssertEqual(sut.currentTurn, "X")
    }

    func testChangeCurrentTurnTo_O_then_X_Multiple() throws {
        let sut = GameController()
        sut.updateTurn()
        XCTAssertEqual(sut.currentTurn, "O")
        sut.updateTurn()
        XCTAssertEqual(sut.currentTurn, "X")
        sut.updateTurn()
        XCTAssertEqual(sut.currentTurn, "O")
        sut.updateTurn()
        XCTAssertEqual(sut.currentTurn, "X")
        sut.updateTurn()
        XCTAssertEqual(sut.currentTurn, "O")
        sut.updateTurn()
        XCTAssertEqual(sut.currentTurn, "X")
    }

}
