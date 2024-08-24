//
//  Square.swift
//  TicTacToeViewInspector
//
//  Created by Brent Michalski on 8/24/24.
//

import Foundation

class Square {
    enum State {
        case empty
        case x
        case o
    }

    let index: Int
    var state = State.empty
    
    init(index: Int = 0) {
        self.index = index
    }
}
