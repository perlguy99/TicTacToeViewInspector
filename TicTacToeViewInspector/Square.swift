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
    let index: Int
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
    
    init(index: Int = 0, action: @escaping () -> Void = { print("default square action") }) {
        if index < 0 {
            self.index = 0
        } else if index > 8 {
            self.index = 0
        } else {
            self.index = index
        }
        
        self.action = action
    }
}
