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

    func testTakeTurnAtUpdatesProperSquareState_X() {
        // Given I have a GameBoardView
        let sut = GameBoardView()
        XCTAssertEqual(sut.controller.gameBoard[0].state, .empty)
        
        // When user takes a turn, state updates
        sut.controller.takeTurnAt(0)
        
        // Then
        XCTAssertEqual(sut.controller.gameBoard[0].state, .x)
    }

    func testTakeTurnAtUpdatesProperSquareState_O() {
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
    
    func testSquareCallback() throws {
        // Given that I have a Game Board
        let sut = GameBoardView()
        
        // When I call a Square's Action
        sut.controller.gameBoard[0].action()

        // Then
        XCTAssertEqual(sut.controller.gameBoard[0].state, .x)
    }
    
    let testXturn = "It's X's turn"
    let testOturn = "It's O's turn"
    let testXwin = "Winner: X"
    let testOwin = "Winner: O"
    let testDraw = "DRAW"
    
    
    
    func testGameBoardTitleIsCorrect() throws {
        // Given that I have a Game Board
        let sut = GameBoardView()
        
        // 🤯 🤓 Automatically updates each time it is called!
        let displayedText = { try sut.inspect().find(viewWithTag: "GameBoardViewTitle").text().string() }
        
        // Is the Play Again Button displayed?
        let playAgainButtonOpacity = { try sut.inspect().find(viewWithTag: "PlayAgainButton").opacity() }
        
        XCTAssertEqual(try displayedText(), testXturn)
        XCTAssertEqual(try playAgainButtonOpacity(), 0.0)
        sut.controller.takeTurnAt(0) // X
        
        XCTAssertEqual(try displayedText(), testOturn)
        XCTAssertEqual(try playAgainButtonOpacity(), 0.0)
        sut.controller.takeTurnAt(3) // O
        
        XCTAssertEqual(try displayedText(), testXturn)
        XCTAssertEqual(try playAgainButtonOpacity(), 0.0)
        sut.controller.takeTurnAt(1) // X
        
        XCTAssertEqual(try displayedText(), testOturn)
        XCTAssertEqual(try playAgainButtonOpacity(), 0.0)
        sut.controller.takeTurnAt(4) // O
        
        XCTAssertEqual(try displayedText(), testXturn)
        XCTAssertEqual(try playAgainButtonOpacity(), 0.0)
        sut.controller.takeTurnAt(2) // X Wins
        
        XCTAssertEqual(try displayedText(), testXwin)
        XCTAssertEqual(try playAgainButtonOpacity(), 1.0)
        
        
        
//        
//        let square = Square()
//        square.state = .x
//        let sut = SquareView(square: square)
//        
//        let displayedImage = try sut.inspect().find(viewWithTag: "SquareView.Rectangle").overlay().image().actualImage()
//        XCTAssertNotEqual(try displayedImage.name(), try! stateEmptyImage.name())
//        XCTAssertEqual(try displayedImage.name(), try! stateXImage.name())
//        XCTAssertNotEqual(try displayedImage.name(), try! stateOImage.name())
    }

    
    func testGameBoardTitleIsCorrect_Turns() throws {
        // Given that I have a Game Board
        let sut = GameBoardView()
        
        // 🤯 🤓 Automatically updates each time it is called!
        let displayedText = { try sut.inspect().find(viewWithTag: "GameBoardViewTitle").text().string() }
        
        // Is the Play Again Button displayed?
        let playAgainButtonOpacity = { try sut.inspect().find(viewWithTag: "PlayAgainButton").opacity() }
        
        XCTAssertEqual(try displayedText(), testXturn)
        XCTAssertEqual(try playAgainButtonOpacity(), 0.0)
        sut.controller.takeTurnAt(0) // X
        
        XCTAssertEqual(try displayedText(), testOturn)
        XCTAssertEqual(try playAgainButtonOpacity(), 0.0)
        sut.controller.takeTurnAt(3) // O
        
        XCTAssertEqual(try displayedText(), testXturn)
        XCTAssertEqual(try playAgainButtonOpacity(), 0.0)
        sut.controller.takeTurnAt(1) // X
        
        // Force .x as the winner
        sut.controller.winner = .x
        
        XCTAssertEqual(try displayedText(), testXwin)
        XCTAssertEqual(try playAgainButtonOpacity(), 1.0)
    }
    
    func testGameBoardTitle_ForceXWin() throws {
        // Given that I have a Game Board
        let sut = GameBoardView()
        
        // 🤯 🤓 Automatically updates each time it is called!
        let displayedText = { try sut.inspect().find(viewWithTag: "GameBoardViewTitle").text().string() }
        
        // Is the Play Again Button displayed?
        let playAgainButtonOpacity = { try sut.inspect().find(viewWithTag: "PlayAgainButton").opacity() }
        
        XCTAssertEqual(try displayedText(), testXturn)
        XCTAssertEqual(try playAgainButtonOpacity(), 0.0)

        sut.controller.winner = .x
        XCTAssertEqual(try playAgainButtonOpacity(), 1.0)
    }
    
    func testGameBoardTitle_ForceOWin() throws {
        // Given that I have a Game Board
        let sut = GameBoardView()
        
        // 🤯 🤓 Automatically updates each time it is called!
        let displayedText = { try sut.inspect().find(viewWithTag: "GameBoardViewTitle").text().string() }
        
        // Is the Play Again Button displayed?
        let playAgainButtonOpacity = { try sut.inspect().find(viewWithTag: "PlayAgainButton").opacity() }
        
        XCTAssertEqual(try displayedText(), testXturn)
        XCTAssertEqual(try playAgainButtonOpacity(), 0.0)

        sut.controller.winner = .o
        XCTAssertEqual(try playAgainButtonOpacity(), 1.0)
    }
    
    func testGameBoardTitle_ForceDraw() throws {
        // Given that I have a Game Board
        let sut = GameBoardView()
        
        // 🤯 🤓 Automatically updates each time it is called!
        let displayedText = { try sut.inspect().find(viewWithTag: "GameBoardViewTitle").text().string() }
        
        // Is the Play Again Button displayed?
        let playAgainButtonOpacity = { try sut.inspect().find(viewWithTag: "PlayAgainButton").opacity() }
        
        XCTAssertEqual(try displayedText(), testXturn)
        XCTAssertEqual(try playAgainButtonOpacity(), 0.0)

        sut.controller.isDraw = true
        XCTAssertEqual(try playAgainButtonOpacity(), 1.0)
    }
}
