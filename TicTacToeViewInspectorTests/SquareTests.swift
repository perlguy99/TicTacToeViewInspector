@testable import TicTacToeViewInspector
import XCTest

final class SquareTests: XCTestCase {
    func testCreateSquare() throws {
        XCTAssertNoThrow(Square())
    }
    
    func testThatSquareInitialStateIsEmpty() throws {
        let sut = Square()
        XCTAssertEqual(sut.state, .empty)
    }
    
    func testThatSquareCanBe_X() throws {
        let sut = Square()
        sut.state = .x
        XCTAssertEqual(sut.state, .x)
    }
    
    func testThatSquareCanBe_O() throws {
        let sut = Square()
        sut.state = .o
        XCTAssertEqual(sut.state, .o)
    }
}
