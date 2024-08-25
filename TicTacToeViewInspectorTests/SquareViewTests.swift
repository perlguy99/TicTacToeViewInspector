@testable import TicTacToeViewInspector
import XCTest

final class SquareViewTests: XCTestCase {
    
    func testCreateSquareView() throws {
        XCTAssertNoThrow(SquareView(square: Square()))
    }
    
}
