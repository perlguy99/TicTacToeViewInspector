//
//  GameController.swift
//  TicTacToeViewInspector
//
//  Created by Brent Michalski on 8/24/24.
//

import SwiftUI

class GameController: ObservableObject {
    @Published var gameResult: GameResult = .inProgress
    @Published var currentTurn: Turn = .x
    
    var gameBoard: [Square] = []
    
    var gameHeaderTitle: String {
        switch gameResult {
        case .inProgress:
            return currentTurn.turnString
        case .winner(let winner):
            return "Winner: \(winner == .x ? "X" : "O")"
        case .draw:
            return "DRAW"
        }
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
        gameResult = .inProgress
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
            gameResult = .winner(currentTurn.state)
        } else if checkForDraw() {
            gameResult = .draw
        } else {
            updateTurn()
        }
    }
    
    func checkForWin() -> Bool {
        let winningPatterns: [[Int]] = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
            [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
            [0, 4, 8], [2, 4, 6] // diagonals
        ]
        
        return winningPatterns.contains { pattern in
            let states = pattern.map { gameBoard[$0].state }
            return states == [.x, .x, .x] || states == [.o, .o, .o]
        }
    }
    
    func checkForDraw() -> Bool {
        return  !gameBoard.contains { $0.state == .empty }
    }
}

// Moved this here to make the GameController clearer
extension GameController {
    enum GameResult: Equatable {
        case winner(Square.State)
        case draw
        case inProgress
    }
}

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
