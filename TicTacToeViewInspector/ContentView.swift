//
//  ContentView.swift
//  TicTacToeViewInspector
//
//  Created by Brent Michalski on 8/24/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            GameBoardView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
