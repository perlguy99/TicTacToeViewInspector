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
    
    // TODO: - Need to write tests for actual squares
    func testSquareViewsDisplayCorrectState_Foo() throws {
        // Given that I have a Game Board
        let sut = GameBoardView()

        // And I take a square from the game board
        let foo = sut.controller.gameBoard[0]
        
        // I can create a Mock SquareView, and test against it!
        let bar = SquareView(square: foo)
        
        let displayedImage = try bar.inspect().find(viewWithTag: "SquareView.Rectangle").overlay().image().actualImage()
        XCTAssertEqual(try displayedImage.name(), try! stateEmptyImage.name())
    }
    
    func testAllSquaresPart1() throws {
        let sut = GameBoardView()
        sut.controller.takeTurnAt(0)
        sut.controller.takeTurnAt(1)
        sut.controller.takeTurnAt(2)
        
        try verifyAllNineSquaresForCorrectState(gameBoardView: sut)
    }
    
    // Taking what we have above, let's make this much easier!
    func getDisplayedImageForSquare(_ square: Square) throws -> Image {
        let squareView = SquareView(square: square)
        let displayedImage = try squareView.inspect().find(viewWithTag: "SquareView.Rectangle").overlay().image().actualImage()
        return displayedImage
    }
    
    // And now test ALL 9 squares at once
    func verifyAllNineSquaresForCorrectState(gameBoardView: GameBoardView) throws {
        // Using the GameBoard passed in...
        
        // All 9 should have no image currently
        // Expecting this to fail
        for index in 0...8 {
            let square = gameBoardView.controller.gameBoard[index]
            let displayedImage = try getDisplayedImageForSquare(square)
            let displayedImageName = try displayedImage.name()
            let squareStateImageName = square.squareImageName
            
            XCTAssertEqual(displayedImageName, squareStateImageName, "At index \(index): \(displayedImageName) does not match: \(squareStateImageName)")
        }
        
    }
    
}

