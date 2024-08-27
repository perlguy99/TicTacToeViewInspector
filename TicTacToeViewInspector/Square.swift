//
//  Square.swift
//  TicTacToeViewInspector
//
//  Created by Brent Michalski on 8/24/24.
//

import Foundation

class Square: ObservableObject {
    enum State {
        case empty
        case x
        case o
    }

    @Published var state = State.empty
//    var state = State.empty
    var action: () -> Void
    
    var squareImageName: String {
        if state == .x {
            return "xmark"
        } else if state == .o {
            return "circle"
        } else {
            return ""
        }
    }

    init(action: @escaping () -> Void = { print("Default Square Action") }) {
        self.action = action
    }
}
