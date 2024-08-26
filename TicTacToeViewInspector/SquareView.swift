//
//  SquareView.swift
//  TicTacToeViewInspector
//
//  Created by Brent Michalski on 8/25/24.
//

import SwiftUI

struct SquareView: View {
    @ObservedObject var square: Square
    
    var body: some View {
        Rectangle()
            .frame(width: 100, height: 100)
            .cornerRadius(10)
            .foregroundStyle(.blue)
            .overlay(
                Image(systemName: square.squareImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
            )
            .tag("SquareView.Rectangle")
            .onTapGesture {
                // Call the controller's takeTurnAt() function
                square.action()
            }
    }
}

#Preview {
    let square1 = Square()
    let square2 = Square()
    let square3 = Square()
    square2.state = .x
    square3.state = .o
    
    return VStack {
        SquareView(square: square1)
        SquareView(square: square2)
        SquareView(square: square3)
    }
}
