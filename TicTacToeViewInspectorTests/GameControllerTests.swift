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
    
    
    func testTakeOneTurnAndCheckForWinner() {
        // Given
        let sut = GameController()
        validateInitialState(sut: sut)
        
        // When I take a turn
        sut.takeTurnAt(0)
        
        // Then
        XCTAssertEqual(sut.currentTurn, .o)
        XCTAssertEqual(sut.gameBoard[0].state, .x)
        XCTAssertNil(sut.winner)
    }

    // MARK: - X
    func testForWin_Expect_X_Row1() {
        // Given
        let sut = GameController()
        validateInitialState(sut: sut)
        
        // When X Wins across the top
        sut.takeTurnAt(0) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(4) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(1) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(3) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(2) // X
        
        // Then
        XCTAssertEqual(sut.currentTurn, .x)
        XCTAssertEqual(sut.winner, .x)
    }

    func testForWin_Expect_X_Row2() {
        // Given
        let sut = GameController()
        validateInitialState(sut: sut)
        
        // When X Wins across row 2
        sut.takeTurnAt(3) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(2) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(4) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(1) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(5) // X
        
        // Then
        XCTAssertEqual(sut.currentTurn, .x)
        XCTAssertEqual(sut.winner, .x)
    }

    func testForWin_Expect_X_Row3() {
        // Given
        let sut = GameController()
        validateInitialState(sut: sut)
        
        // When X Wins across row 3
        sut.takeTurnAt(6) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(4) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(7) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(3) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(8) // X
        
        // Then
        XCTAssertEqual(sut.currentTurn, .x)
        XCTAssertEqual(sut.winner, .x)
    }

    func testForWin_Expect_X_Col1() {
        // Given
        let sut = GameController()
        validateInitialState(sut: sut)
        
        // When X Wins in 1st column
        sut.takeTurnAt(0) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(4) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(3) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(2) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(6) // X
        
        // Then
        XCTAssertEqual(sut.currentTurn, .x)
        XCTAssertEqual(sut.winner, .x)
    }
    
    func testForWin_Expect_X_Col2() {
        // Given
        let sut = GameController()
        validateInitialState(sut: sut)
        
        // When X Wins across the top
        sut.takeTurnAt(1) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(2) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(4) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(3) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(7) // X
        
        // Then
        XCTAssertEqual(sut.currentTurn, .x)
        XCTAssertEqual(sut.winner, .x)
    }

    func testForWin_Expect_X_Col3() {
        // Given
        let sut = GameController()
        validateInitialState(sut: sut)
        
        // When X Wins across the top
        sut.takeTurnAt(2) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(4) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(5) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(3) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(8) // X
        
        // Then
        XCTAssertEqual(sut.currentTurn, .x)
        XCTAssertEqual(sut.winner, .x)
    }
    
    func testForWin_Expect_X_Diagonal1() {
        // Given
        let sut = GameController()
        validateInitialState(sut: sut)
        
        // When X Wins diagonally, top left to bottom right
        sut.takeTurnAt(0) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(2) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(4) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(3) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(8) // X
        
        // Then
        XCTAssertEqual(sut.currentTurn, .x)
        XCTAssertEqual(sut.winner, .x)
    }

    func testForWin_Expect_X_Diagonal2() {
        // Given
        let sut = GameController()
        validateInitialState(sut: sut)
        
        // When X Wins diagonally, top right to bottom left
        sut.takeTurnAt(2) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(5) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(4) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(3) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(6) // X
        
        // Then
        XCTAssertEqual(sut.currentTurn, .x)
        XCTAssertEqual(sut.winner, .x)
    }

    // MARK: - O
    func testForWin_Expect_O_Row1() {
        // Given
        let sut = GameController()
        validateInitialState(sut: sut)
        
        // When O Wins across the top
        sut.takeTurnAt(6) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(0) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(4) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(1) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(8) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(2) // O
        
        // Then
        XCTAssertEqual(sut.currentTurn, .o)
        XCTAssertEqual(sut.winner, .o)
    }

    func testForWin_Expect_O_Row2() {
        // Given
        let sut = GameController()
        validateInitialState(sut: sut)
        
        // When O Wins across row 2
        sut.takeTurnAt(6) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(3) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(2) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(4) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(8) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(5) // O
        
        // Then
        XCTAssertEqual(sut.currentTurn, .o)
        XCTAssertEqual(sut.winner, .o)
    }
    
    func testForWin_Expect_O_Row3() {
        // Given
        let sut = GameController()
        validateInitialState(sut: sut)
        
        // When O Wins across row 3
        sut.takeTurnAt(1) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(6) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(4) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(7) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(5) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(8) // O
        
        // Then
        XCTAssertEqual(sut.currentTurn, .o)
        XCTAssertEqual(sut.winner, .o)
    }

    func testForWin_Expect_O_Col1() {
        // Given
        let sut = GameController()
        validateInitialState(sut: sut)
        
        // When X Wins in 1st column
        sut.takeTurnAt(0) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(4) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(3) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(2) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(6) // X
        
        // Then
        XCTAssertEqual(sut.currentTurn, .x)
        XCTAssertEqual(sut.winner, .x)
    }
    
    func testForWin_Expect_O_Col2() {
        // Given
        let sut = GameController()
        validateInitialState(sut: sut)
        
        // When X Wins across the top
        sut.takeTurnAt(1) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(2) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(4) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(3) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(7) // X
        
        // Then
        XCTAssertEqual(sut.currentTurn, .x)
        XCTAssertEqual(sut.winner, .x)
    }

    func testForWin_Expect_O_Col3() {
        // Given
        let sut = GameController()
        validateInitialState(sut: sut)
        
        // When X Wins across the top
        sut.takeTurnAt(2) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(4) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(5) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(3) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(8) // X
        
        // Then
        XCTAssertEqual(sut.currentTurn, .x)
        XCTAssertEqual(sut.winner, .x)
    }

    func testForWin_Expect_O_Diagonal1() {
        // Given
        let sut = GameController()
        validateInitialState(sut: sut)
        
        // When O Wins diagonally, top left to bottom right
        sut.takeTurnAt(3) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(0) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(2) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(4) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(6) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(8) // O
        
        // Then
        XCTAssertEqual(sut.currentTurn, .o)
        XCTAssertEqual(sut.winner, .o)
    }

    func testForWin_Expect_O_Diagonal2() {
        // Given
        let sut = GameController()
        validateInitialState(sut: sut)
        
        // When O Wins diagonally, top right to bottom left
        sut.takeTurnAt(5) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(2) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(1) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(4) // O
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(3) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(6) // O
        
        // Then
        XCTAssertEqual(sut.currentTurn, .o)
        XCTAssertEqual(sut.winner, .o)
    }
    
    // MARK: - Draw
    func testForWin_Expect_DRAW() throws {
        let sut = GameController()
        validateInitialState(sut: sut)
        
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(1) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(0) // O

        XCTAssertNil(sut.winner)
        sut.takeTurnAt(5) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(2) // O

        XCTAssertNil(sut.winner)
        sut.takeTurnAt(4) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(3) // O

        XCTAssertNil(sut.winner)
        sut.takeTurnAt(6) // X
        XCTAssertNil(sut.winner)
        sut.takeTurnAt(7) // O

        XCTAssertNil(sut.winner)
        sut.takeTurnAt(8) // X
        
        XCTAssertNil(sut.winner)
        XCTAssertTrue(sut.isDraw)
    }
    
    func testGameControllerReset() {
        // Given
        let sut = GameController()
        validateInitialState(sut: sut)

        sut.updateTurn()
        XCTAssertEqual(sut.currentTurn, .o)

        // When
        sut.reset()
        
        // Then
        validateInitialState(sut: sut)
    }
    
    func testGameHeaderTitle() {
        let sut = GameController()
        
        XCTAssertEqual(sut.gameHeaderTitle, "It's X's turn")
        sut.updateTurn()
        XCTAssertEqual(sut.gameHeaderTitle, "It's O's turn")
    }
    
    func testGameHeaderTitleWhen_X_Wins() {
        let sut = GameController()
        sut.takeTurnAt(0)
        sut.takeTurnAt(3)
        sut.takeTurnAt(1)
        sut.takeTurnAt(4)
        sut.takeTurnAt(2)
        
        // X Won
        XCTAssertEqual(sut.gameHeaderTitle, "Winner: X")
    }

    func testGameHeaderTitleWhen_O_Wins() {
        let sut = GameController()
        sut.takeTurnAt(3)
        sut.takeTurnAt(0)
        sut.takeTurnAt(4)
        sut.takeTurnAt(1)
        sut.takeTurnAt(7)
        sut.takeTurnAt(2)
        
        // O Won
        XCTAssertEqual(sut.gameHeaderTitle, "Winner: O")
    }

    func testGameHeaderTitleWhen_Draw() {
        let sut = GameController()

        sut.takeTurnAt(1)
        sut.takeTurnAt(0)
        sut.takeTurnAt(2)
        sut.takeTurnAt(5)
        sut.takeTurnAt(3)
        sut.takeTurnAt(6)
        sut.takeTurnAt(4)
        sut.takeTurnAt(7)
        sut.takeTurnAt(8)

        // DRAW
        XCTAssertEqual(sut.gameHeaderTitle, "DRAW")
    }

    
    // MARK: - Helper Functions
    func validateInitialState(sut: GameController) {
        XCTAssertEqual(sut.currentTurn, .x)
        XCTAssertEqual(sut.gameBoard.count, 9)
        XCTAssertNil(sut.winner)
        XCTAssertFalse(sut.isDraw)
        
        validateEmptyGameBoard(sut: sut)
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
