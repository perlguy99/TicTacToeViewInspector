//
//  SquareView.swift
//  TicTacToeViewInspector
//
//  Created by Brent Michalski on 8/25/24.
//

import SwiftUI

struct SquareView: View {
    let square: Square
    
    var body: some View {
        Rectangle()
            .frame(width: 100, height: 100)
            .cornerRadius(10)
            .foregroundStyle(.blue)
            .overlay(
                Image(systemName: square.squareImageName)
                    .resizable()
                    .frame(width: 75, height: 75)
            )
            .tag("SquareView.Rectangle")
            .onTapGesture {
                // When square is tapped...
                // we need to call the controller's takeTurnAt() function
                
                
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
