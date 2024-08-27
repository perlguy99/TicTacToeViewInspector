//
//  GameController.swift
//  TicTacToeViewInspector
//
//  Created by Brent Michalski on 8/24/24.
//

import SwiftUI

class GameController: ObservableObject {
    // This on must be @Published
    @Published var winner: Square.State? {
        didSet {
            if winner != nil {
                gameOver = true
            }
        }
    }
//    @Published var isDraw = false
    var isDraw = false {
        didSet {
            if isDraw {
                gameOver = true
            }
        }
    }

    var currentTurn: Turn = .x
    var gameBoard: [Square] = []
    var gameOver = false
    
    var gameHeaderTitle: String {
        var returnString = "DEFAULT"

        if gameOver {
            if let winner = winner {
                returnString = "Winner: "
                if winner == .x {
                    returnString += "X"
                } else if winner == .o {
                    returnString += "O"
                }
            } else {
                returnString = "DRAW"
            }
        } else {
            returnString = currentTurn.turnString
        }
        
        return returnString
    }
    
    init() {
        self.reset()
    }
    
    func reset() {
        gameBoard = (0..<9).map { index in
            Square() { [unowned self] in
                self.takeTurnAt(index)
            }
        }
        
        currentTurn = .x
        winner = nil
        isDraw = false
        gameOver = false
    }
    
    func updateTurn() {
        currentTurn = (currentTurn == .x ? .o : .x)
    }
    
    func takeTurnAt(_ index: Int) {
        let square = gameBoard[index]
        
        if square.state != .empty { return }
        
        gameBoard[index].state = currentTurn.state
        
        // Before we update the Turn, we need to see if the current player won
        if checkForWin() {
            // The current player just won
            // So we do NOT want to call updateTurn()
            winner = currentTurn.state
        } else {
            // But if no winner, then check for a Draw and call updateTurn()
            checkForDraw()
            updateTurn()
        }
    }
    
    func checkForWin() -> Bool {
        let winningPatterns: [[Int]] = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
            [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
            [0, 4, 8], [2, 4, 6] // diagonals
        ]
        
        for pattern in winningPatterns {
            let states = pattern.map { gameBoard[$0].state }
            
            if states == [.x, .x, .x] {
                winner = .x
                gameOver = true
                return true
            } else if states == [.o, .o, .o] {
                winner = .o
                gameOver = true
                return true
            } 
        }
        
        return false
    }
    
    func checkForDraw() {
        if (!gameBoard.contains { $0.state == .empty }) {
            gameOver = true
            isDraw = true
        }
    }
}

// Moved this here to make the GameController clearer
extension GameController {
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

        var turnString: String {
            switch self {
            case .x:
                return "It's X's turn"
            case .o:
                return "It's O's turn"
            }
        }
    }
}
