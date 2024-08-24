//
//  GameController.swift
//  TicTacToeViewInspector
//
//  Created by Brent Michalski on 8/24/24.
//

import SwiftUI

class GameController {
    var currentTurn = "X"
    
    func updateTurn() {
        currentTurn = currentTurn == "X" ? "O" : "X"
    }
}
