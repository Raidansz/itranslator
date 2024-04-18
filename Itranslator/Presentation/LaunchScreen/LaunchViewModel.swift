//
//  LaunchViewModel.swift
//  Itranslator
//
//  Created by Raidan on 18/04/2024.
//

import Foundation



class LaunchViewModel: ObservableObject {
    
    @Published var opacities: [Double] = []
    
    
    init(languagesCount: Int) {
        startOpacityAnimation(languagesCount: languagesCount)
    }
    
    func startOpacityAnimation(languagesCount: Int) {
        // Initialize opacities with alternating values to simulate fading in and out
        for index in 0..<languagesCount {
            opacities.append(Double(index % 2))
        }
        
        // Update opacities every 2 seconds to simulate fading in and out smoothly
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
            for index in 0..<self.opacities.count {
                self.opacities[index] = self.opacities[index] == 1 ? 0 : 1
            }
            self.objectWillChange.send()
        }
    }
}
