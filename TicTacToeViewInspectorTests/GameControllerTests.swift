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
        XCTAssertEqual(sut.currentTurn, .x)
    }
    
    func testChangeCurrentTurn() throws {
        let sut = GameController()
        sut.updateTurn()
        XCTAssertEqual(sut.currentTurn, .o)
    }
    
    func testChangeCurrentTurnTo_O_then_X() throws {
        let sut = GameController()
        sut.updateTurn()
        XCTAssertEqual(sut.currentTurn, .o)
        sut.updateTurn()
        XCTAssertEqual(sut.currentTurn, .x)
    }

    func testChangeCurrentTurnTo_O_then_X_Multiple() throws {
        let sut = GameController()
        sut.updateTurn()
        XCTAssertEqual(sut.currentTurn, .o)
        sut.updateTurn()
        XCTAssertEqual(sut.currentTurn, .x)
        sut.updateTurn()
        XCTAssertEqual(sut.currentTurn, .o)
        sut.updateTurn()
        XCTAssertEqual(sut.currentTurn, .x)
        sut.updateTurn()
        XCTAssertEqual(sut.currentTurn, .o)
        sut.updateTurn()
        XCTAssertEqual(sut.currentTurn, .x)
    }

    func testThatGameBoardExists() throws {
        let sut = GameController()
        XCTAssertNotNil(sut.gameBoard)
    }
    
    func testInitialStateOfGameBoard() throws {
        let sut = GameController()
        validateInitialState(sut: sut)
        validateEmptyGameBoard(sut: sut)
    }

    func testTakeOneTurn() {
        // Given
        let sut = GameController()
        validateInitialState(sut: sut)
        
        // When I take a turn
        sut.takeTurnAt(0)
        
        // Then
        XCTAssertEqual(sut.currentTurn, .o)
        XCTAssertEqual(sut.gameBoard[0].state, .x)
    }

    func testThatYouCantTakeATurnIfItHasBeenPicked() {
        // Given
        let sut = GameController()
        validateInitialState(sut: sut)
        sut.takeTurnAt(0)
        XCTAssertEqual(sut.currentTurn, .o)
        XCTAssertEqual(sut.gameBoard[0].state, .x)
        
        // When the user tries to move in an occupied space
        sut.takeTurnAt(0)
        
        // Then, nothing should change or update
        XCTAssertEqual(sut.currentTurn, .o)
        XCTAssertEqual(sut.gameBoard[0].state, .x)
    }

    
    
    // MARK: - Helper Functions
    func validateInitialState(sut: GameController) {
        XCTAssertEqual(sut.currentTurn, .x)
        XCTAssertEqual(sut.gameBoard.count, 9)
    }
    
    func validateEmptyGameBoard(sut: GameController) {
        // All 9 squares need to be "Empty"
        for square in sut.gameBoard {
            XCTAssertEqual(square.state, .empty)
        }
        
        for square in sut.gameBoard {
            XCTAssertNotEqual(square.state, .x)
        }

        for square in sut.gameBoard {
            XCTAssertNotEqual(square.state, .o)
        }
    }

}
