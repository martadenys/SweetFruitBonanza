//
//  WheelViewModel.swift
//  Sweet&Fruit Bonanza
//
//  Created by Roman Samborskyi on 20.09.2023.
//

import Foundation
import AVFoundation

class WheelViewModel: ObservableObject {
    
    
    @Published var images: [String] = ["1","9","3","4","5","6","7","8"]
    @Published var coloredImages: [String] = []
    @Published var soundEffect: Bool = true
    private let userDefaultArrayName: String = "coloredImages"
    
    init() {
        getFromUserDefaults()
    }
    
    func calculateSegment(at angle: CGFloat, images: [String]) -> String {
        let segmentCount = images.count
        let anglePerSegment = (2 * .pi) / CGFloat(segmentCount)
        let normalizedAngle = (angle + .pi * 2).truncatingRemainder(dividingBy: .pi * 2)
        let segmentIndex = Int((normalizedAngle + anglePerSegment / 2) / anglePerSegment)
        let clampedSegmentIndex = segmentIndex < 0 ? segmentCount - 1 : segmentIndex % segmentCount
        return images[clampedSegmentIndex]
    }
    
    func saveColoredImage(for name: String) {
        coloredImages.append(name)
        UserDefaults.standard.setValue(coloredImages, forKey: userDefaultArrayName)
    }
    
    func getFromUserDefaults() {
        if let localArray = UserDefaults.standard.array(forKey: userDefaultArrayName) as? [String] {
            coloredImages = localArray
        } else {
            coloredImages = []
        }
    }
    
        func makeClick() {
            let systemSoundId: SystemSoundID = 1104
            AudioServicesPlaySystemSound(systemSoundId)
        }
    func winSound() {
        let systemSoundId: SystemSoundID = 1322
        AudioServicesPlaySystemSound(systemSoundId)
    }
    
}
