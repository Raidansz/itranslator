//
//  ToolbarPrincipalView.swift
//  Itranslator
//
//  Created by Raidan on 28/04/2024.
//

import SwiftUI

struct ToolbarPrincipalView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
           HStack {
               Text("Itranslator")
                   .font(.title)
                   .bold()
                   .foregroundColor(.primary)
               Spacer()
           }
    }
}

#Preview("Light mode") {
    ToolbarPrincipalView()
}
#Preview("Dark mode") {
    ToolbarPrincipalView().environment(\.colorScheme, .dark).background(.black)
}
