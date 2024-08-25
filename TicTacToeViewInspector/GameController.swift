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
        
        var state: Square.State {
            switch self {
            case .x:
                return .x
            case .o:
                return .o
            }
        }
    }
    
    var currentTurn: Turn = .x
    var gameBoard: [Square] = []
    
    init() {
        gameBoard = [Square(), Square(), Square(), Square(), Square(), Square(), Square(), Square(), Square()]
    }
    
    func updateTurn() {
        currentTurn = currentTurn == .x ? .o : .x
    }
    
    func takeTurnAt(_ index: Int) {
        gameBoard[index].state = currentTurn.state
        updateTurn()
    }
}
