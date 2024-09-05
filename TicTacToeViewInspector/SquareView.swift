//
//  SquareView.swift
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
/// The `GameController` owns the `Square` and is responsible for managing the lifecycle of the GameBoard's objects.
///
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
                square.action() // GameController's takeTurnAt() function
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
