//
//  GameBoardView.swift
//  TicTacToeViewInspector
//
//  Created by Brent Michalski on 8/25/24.
//

import SwiftUI

struct GameBoardView: View {
    @ObservedObject var controller = GameController()
    
    internal let inspection = Inspection<Self>()
    
    var body: some View {
        VStack {
            Text(controller.gameHeaderTitle)
                .tag("GameBoardViewTitle")
                .font(.title)
            
            Group {
                HStack {
                    SquareView(square: controller.gameBoard[0])
                    SquareView(square: controller.gameBoard[1])
                    SquareView(square: controller.gameBoard[2])
                }
                HStack {
                    SquareView(square: controller.gameBoard[3])
                    SquareView(square: controller.gameBoard[4])
                    SquareView(square: controller.gameBoard[5])
                }
                HStack {
                    SquareView(square: controller.gameBoard[6])
                    SquareView(square: controller.gameBoard[7])
                    SquareView(square: controller.gameBoard[8])
                }
            }
            // Disable when there is a winner.
            .disabled(controller.gameResult != .inProgress)
            
            Button("Play Again?") {
                controller.reset()
            }
            .tag("PlayAgainButton")
            .buttonStyle(.borderedProminent)
            .opacity(controller.gameResult == .inProgress ? 0 : 1)
            .disabled(controller.gameResult == .inProgress)
        }
        .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
}

#Preview {
    GameBoardView()
}
