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
        
        // Also, verify that all SquareViews are displaying the proper image, if any.
        try? verifyAllNineSquaresForCorrectState(gameBoardView: sut)
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
        
        // Also, verify that all SquareViews are displaying the proper image, if any.
        try? verifyAllNineSquaresForCorrectState(gameBoardView: sut)
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

    
    /// Views using `@ObservedObject`
    ///
    /// `ViewInspector` provides full support for such views, so you can inspect them without any intervention in the source code.
    ///
    /// Unlike the views using `@State`,` @Environment` or `@EnvironmentObject`, the state changes inside `@Binding` and `@ObservedObject` can be evaluated with synchronous tests. You may consider, however, using the asynchronous approach described below, just for the sake of the tests consistency.
    @MainActor func testGameBoardTitleIsCorrect_MoreViewInspector() throws {
        // Given that I have a Game Board
        let sut = GameBoardView()
        
        let exp = sut.inspection.inspect { view in
            XCTAssert(try view.actualView().inspect().find(viewWithTag: "GameBoardViewTitle").text().string() == "It's X's turn")
            try view.actualView().controller.gameBoard[0].action() // X
            XCTAssert(try view.actualView().inspect().find(viewWithTag: "GameBoardViewTitle").text().string() == "It's O's turn")
            try view.actualView().controller.gameBoard[3].action() // O
            XCTAssert(try view.actualView().inspect().find(viewWithTag: "GameBoardViewTitle").text().string() == "It's X's turn")
            try view.actualView().controller.gameBoard[1].action() // X
            XCTAssert(try view.actualView().inspect().find(viewWithTag: "GameBoardViewTitle").text().string() == "It's O's turn")
            try view.actualView().controller.gameBoard[4].action() // O
            XCTAssert(try view.actualView().inspect().find(viewWithTag: "GameBoardViewTitle").text().string() == "It's X's turn")
            try view.actualView().controller.gameBoard[2].action() // X Wins
            XCTAssert(try view.actualView().inspect().find(viewWithTag: "GameBoardViewTitle").text().string() == "Winner: X")
        }
        
        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 0.2)
        
        // Different way of testing the same thing
        // 🤯 🤓 Automatically updates each time it is called!
        let displayedText = { try sut.inspect().find(viewWithTag: "GameBoardViewTitle").text().string() }
        
        // Is the Play Again Button displayed?
        let playAgainButtonOpacity = { try sut.inspect().find(viewWithTag: "PlayAgainButton").opacity() }

        // Must reset
        sut.controller.reset()
        
        XCTAssertEqual(try displayedText(), testXturn)
        XCTAssertEqual(try playAgainButtonOpacity(), 0.0)
        sut.controller.takeTurnAt(0) // X
        
        let foo = try sut.inspect().find(viewWithTag: "GameBoardViewTitle").text().string()
        XCTAssertEqual(foo, testOturn)
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
        
        // Also, verify that all SquareViews are displaying the proper image, if any.
        try? verifyAllNineSquaresForCorrectState(gameBoardView: sut)
    }
    
    @MainActor func testGameBoardTitleIsCorrect_MoreViewInspector2() throws {
        // Given that I have a Game Board
        let sut = GameBoardView()
        
        // 🤯 🤓 Automatically updates each time it is called!
        let displayedText = { try sut.inspect().find(viewWithTag: "GameBoardViewTitle").text().string() }
        
        // Is the Play Again Button displayed?
        let playAgainButtonOpacity = { try sut.inspect().find(viewWithTag: "PlayAgainButton").opacity() }

        XCTAssertEqual(try displayedText(), testXturn)
        XCTAssertEqual(try playAgainButtonOpacity(), 0.0)
        sut.controller.gameBoard[0].action() // X

        let foo = try sut.inspect().find(viewWithTag: "GameBoardViewTitle").text().string()
        XCTAssertEqual(foo, testOturn)
        XCTAssertEqual(try playAgainButtonOpacity(), 0.0)
        sut.controller.gameBoard[3].action() // O

        XCTAssertEqual(try displayedText(), testXturn)
        XCTAssertEqual(try playAgainButtonOpacity(), 0.0)
        sut.controller.gameBoard[1].action() // X

        XCTAssertEqual(try displayedText(), testOturn)
        XCTAssertEqual(try playAgainButtonOpacity(), 0.0)
        sut.controller.gameBoard[4].action() // O

        XCTAssertEqual(try displayedText(), testXturn)
        XCTAssertEqual(try playAgainButtonOpacity(), 0.0)
        sut.controller.gameBoard[2].action() // X Wins

        XCTAssertEqual(try displayedText(), testXwin)
        XCTAssertEqual(try playAgainButtonOpacity(), 1.0)
        
        // Also, verify that all SquareViews are displaying the proper image, if any.
        try? verifyAllNineSquaresForCorrectState(gameBoardView: sut)
    }
    
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
        
        // Also, verify that all SquareViews are displaying the proper image, if any.
        try? verifyAllNineSquaresForCorrectState(gameBoardView: sut)
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
        sut.controller.gameResult = .winner(.x)
        
        XCTAssertEqual(try displayedText(), testXwin)
        XCTAssertEqual(try playAgainButtonOpacity(), 1.0)
        
        // Also, verify that all SquareViews are displaying the proper image, if any.
        try? verifyAllNineSquaresForCorrectState(gameBoardView: sut)
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

        sut.controller.gameResult = .winner(.x)
        XCTAssertEqual(try playAgainButtonOpacity(), 1.0)
        
        // Also, verify that all SquareViews are displaying the proper image, if any.
        try? verifyAllNineSquaresForCorrectState(gameBoardView: sut)
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

        sut.controller.gameResult = .winner(.o)
        XCTAssertEqual(try playAgainButtonOpacity(), 1.0)
        
        // Also, verify that all SquareViews are displaying the proper image, if any.
        try? verifyAllNineSquaresForCorrectState(gameBoardView: sut)
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

        sut.controller.gameResult = .draw
        XCTAssertEqual(try playAgainButtonOpacity(), 1.0)
        
        // Also, verify that all SquareViews are displaying the proper image, if any.
        try? verifyAllNineSquaresForCorrectState(gameBoardView: sut)
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
        for (index, square) in gameBoardView.controller.gameBoard.enumerated() {
            let displayedImageName = try getDisplayedImageForSquare(square).name()
            
            print("At index \(index): \(displayedImageName) should be: \(square.squareImageName)")
            
            XCTAssertEqual(
                displayedImageName,
                square.squareImageName,
                "At index \(index): \(displayedImageName) does not match \(square.squareImageName)"
            )
        }
    }
    
    /// Passes whether `currentTurn` is `@Published` or not.
    /// But, when NOT `@Published`, the headerTitle doesn't display correctly.
    func testGameBoardTitleIsCorrect_Q1a() throws {
        // Given that I have a Game Board
        let sut = GameBoardView()
        
        let displayedText = { try sut.inspect().find(viewWithTag: "GameBoardViewTitle").text().string() }
        
        XCTAssertEqual(try displayedText(), "It's X's turn")
        sut.controller.takeTurnAt(0) // X
        XCTAssertEqual(try displayedText(), "It's O's turn")
    }

    /// Passes whether `currentTurn` is `@Published` or not.
    /// /// But, when NOT `@Published`, the headerTitle doesn't display correctly.
    @MainActor func testGameBoardTitleIsCorrect_MoreViewInspector_Q1b() throws {
        // Given that I have a Game Board
        let sut = GameBoardView()
//        sut.controller.gameBoard[0].action()
        
        let exp = sut.inspection.inspect { view in
            XCTAssert(try view.actualView().inspect().find(viewWithTag: "GameBoardViewTitle").text().string() == "It's X's turn")
            
            /// Doesn't seem to matter _how_ I call the action()
//            sut.controller.takeTurnAt(0)
            try view.actualView().controller.gameBoard[1].action()  // Most accurate
//            try view.actualView().controller.takeTurnAt(0)

            XCTAssert(try view.actualView().inspect().find(viewWithTag: "GameBoardViewTitle").text().string() == "It's O's turn")
        }
        
        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 0.1)
    }
    
    
}

