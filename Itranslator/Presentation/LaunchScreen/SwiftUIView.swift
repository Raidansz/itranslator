//
//  SwiftUIView.swift
//  Itranslator
//
//  Created by Raidan on 28/04/2024.
//

import SwiftUI

struct SwiftUIView: View {
    @State private var isShowingDestinationView = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.green)
                .frame(width: 50, height: 50)
                .zIndex(1)

            Rectangle()
                .fill(.red)
                .frame(width: 100, height: 100)
        }
    }
}



struct DestinationView: View {
    var body: some View {
        Text("Destination View")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
