@testable import TicTacToeViewInspector
import XCTest
import ViewInspector
import SwiftUI

final class SquareViewTests: XCTestCase {
    let stateEmptyImage = Image(systemName: "")
    let stateXImage = Image(systemName: "xmark")
    let stateOImage = Image(systemName: "circle")

    func testCreateSquareView() throws {
        XCTAssertNoThrow(SquareView(square: Square()))
    }
    
    func testSquareViewDisplaysEmptyUponInit() throws {
        let sut = SquareView(square: Square())
        
        let displayedImage = try sut.inspect().find(viewWithTag: "SquareView.Rectangle").overlay().image().actualImage()
        XCTAssertEqual(try displayedImage.name(), try! stateEmptyImage.name())
        XCTAssertNotEqual(try displayedImage.name(), try! stateXImage.name())
        XCTAssertNotEqual(try displayedImage.name(), try! stateOImage.name())
    }
    
    func testSquareViewDisplaysCorrectState_X() throws {
        let square = Square()
        square.state = .x
        let sut = SquareView(square: square)
        
        let displayedImage = try sut.inspect().find(viewWithTag: "SquareView.Rectangle").overlay().image().actualImage()
        XCTAssertNotEqual(try displayedImage.name(), try! stateEmptyImage.name())
        XCTAssertEqual(try displayedImage.name(), try! stateXImage.name())
        XCTAssertNotEqual(try displayedImage.name(), try! stateOImage.name())
    }

    func testSquareViewDisplaysCorrectState_O() throws {
        let square = Square()
        square.state = .o
        let sut = SquareView(square: square)
        
        let displayedImage = try sut.inspect().find(viewWithTag: "SquareView.Rectangle").overlay().image().actualImage()
        XCTAssertNotEqual(try displayedImage.name(), try! stateEmptyImage.name())
        XCTAssertNotEqual(try displayedImage.name(), try! stateXImage.name())
        XCTAssertEqual(try displayedImage.name(), try! stateOImage.name())
    }
    
    func testWhenSquareIsTappedItUpdatesProperly() {
        let sut = SquareView(square: Square())
        
        
    }

}
