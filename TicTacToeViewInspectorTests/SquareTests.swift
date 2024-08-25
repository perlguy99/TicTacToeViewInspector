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
    
    func testSquareIndexPropertyBoundaries() {
        let sut1 = Square(index: -1)
        XCTAssertEqual(sut1.state, .empty)
        XCTAssertEqual(sut1.index, 0)
        
        let sut2 = Square(index: 9)
        XCTAssertEqual(sut2.state, .empty)
        XCTAssertEqual(sut2.index, 0)
        
        let sut3 = Square(index: 100)
        XCTAssertEqual(sut3.state, .empty)
        XCTAssertEqual(sut3.index, 0)
    }

    
}
