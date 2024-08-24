@testable import TicTacToeViewInspector
import XCTest

final class SquareTests: XCTestCase {
    func testCreateSquare() throws {
        XCTAssertNoThrow(Square())
    }
    
    func testThatSquareInitialStateIsEmpty() throws {
        let sut = Square()
        XCTAssertEqual(sut.state, .empty)
        XCTAssertEqual(sut.index, 0)
    }
    
    func testThatSquareCanBe_X() throws {
        let sut = Square()
        sut.state = .x
        XCTAssertEqual(sut.state, .x)
        XCTAssertEqual(sut.index, 0)
    }

    func testThatSquareCanBe_O() throws {
        let sut = Square()
        sut.state = .o
        XCTAssertEqual(sut.state, .o)
        XCTAssertEqual(sut.index, 0)
    }
    
    func testSquareIndexProperty() {
        let sut = Square(index: 1)
        XCTAssertEqual(sut.state, .empty)
        XCTAssertEqual(sut.index, 1)
    }
}
