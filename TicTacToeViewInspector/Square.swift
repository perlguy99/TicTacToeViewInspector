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
        if index < 0 {
            self.index = 0
        } else if index > 8 {
            self.index = 0
        } else {
            self.index = index
        }
    }
}
