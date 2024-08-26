//
//  GameBoardView.swift
//  TicTacToeViewInspector
//
//  Created by Brent Michalski on 8/25/24.
//

import SwiftUI

struct GameBoardView: View {
    @ObservedObject var controller = GameController()
    
    var body: some View {
        VStack {
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
    }
}

#Preview {
    GameBoardView()
}
