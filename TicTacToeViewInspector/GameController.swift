//
//  GameController.swift
//  TicTacToeViewInspector
//
//  Created by Brent Michalski on 8/24/24.
//

import SwiftUI


class GameController {
    enum Turn {
        case x
        case o
    }
    
    var currentTurn: Turn = .x
    var gameBoard: [Square] = []
    
    init() {
        gameBoard = [Square(), Square(), Square(), Square(), Square(), Square(), Square(), Square(), Square()]
    }
    
    func updateTurn() {
        currentTurn = currentTurn == .x ? .o : .x
    }
}
