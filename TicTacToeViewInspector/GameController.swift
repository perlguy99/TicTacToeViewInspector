//
//  GameController.swift
//  TicTacToeViewInspector
//
//  Created by Brent Michalski on 8/24/24.
//

import SwiftUI

enum Turn {
    case x
    case o
}

class GameController {
    var currentTurn: Turn = .x
    
    func updateTurn() {
        currentTurn = currentTurn == .x ? .o : .x
    }
}
