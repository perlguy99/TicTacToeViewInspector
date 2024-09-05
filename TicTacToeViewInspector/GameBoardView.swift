//
//  GameBoardView.swift
//  TicTacToeViewInspector
//
//  Created by Brent Michalski on 8/25/24.
//

import SwiftUI

/// I was asked why I didn't make this a `@StateObject` instead of `@ObservedObject`
/// I wasn't exactly sure at the time, so I looked into it further.
/// 
/// As a `@StateObject`, the app seems to work properlty when I run it in the simulator,
/// however, when I run my unit tests it throws an exception and I get several messages like this:
///
/// `Accessing StateObject's object without being installed on a View. This will create a new instance each time.`
///
/// Using `@ObservedObject` is the correct choice here.
///
/// `@ObservedObject`: The view observes an object that is created and owned elsewhere. It does not manage the object's lifecycle.
/// `@StateObject`: The view creates and owns the observable object. It manages the object's lifecycle, ensuring it persists across view updates.
///
/// The `GameController` owns the `GameBoard` and is responsible for managing the lifecycle of the GameBoard's objects.
///
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
