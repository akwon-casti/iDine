//
//  ContentView.swift
//  iDine
//
//  Created by Angela Kwon on 1/5/26.
//

import SwiftUI

struct ContentView: View {
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")

    var body: some View { // required by the protocol
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            NavigationStack {
                List {
                    ForEach(menu) { section in
                        // contextual type for closure argument refers to parameters it should accept and return
                        Text("Hello, world!")
                        Text("Hello, world!")
                        Text("Hello, world!")
                    }
                }
                .navigationTitle("Menu")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
