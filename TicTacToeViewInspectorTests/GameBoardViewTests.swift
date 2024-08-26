@testable import TicTacToeViewInspector
import XCTest
import ViewInspector
import SwiftUI

final class GameBoardViewTests: XCTestCase {
    let stateEmptyImage = Image(systemName: "")
    let stateXImage = Image(systemName: "xmark")
    let stateOImage = Image(systemName: "circle")

    func testCreateGameBoardView() throws {
        XCTAssertNoThrow(GameBoardView())
    }

    func testThatWhenITapASquareItChangesTo_X() {
        // Given I have a GameBoardView
        let sut = GameBoardView()
        XCTAssertEqual(sut.controller.gameBoard[0].state, .empty)
        
        // When user takes a turn, state updates
        sut.controller.takeTurnAt(0)
        
        // Then
        XCTAssertEqual(sut.controller.gameBoard[0].state, .x)
    }

    func testThatWhenITapASquareItChangesTo_O() {
        // Given I have a GameBoardView
        let sut = GameBoardView()
        XCTAssertEqual(sut.controller.gameBoard[0].state, .empty)
        
        // When user takes a turn, state updates
        sut.controller.takeTurnAt(0) // X
        XCTAssertEqual(sut.controller.gameBoard[0].state, .x)
        
        // Then
        sut.controller.takeTurnAt(1) // O
        XCTAssertEqual(sut.controller.gameBoard[1].state, .o)
    }

}
