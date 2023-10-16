//
//  SoundManager.swift
//  Sweet&Fruit Bonanza
//
//  Created by Roman Samborskyi on 14.10.2023.
//

import Foundation
import AVKit



class SoundManager {
    
    static let instance = SoundManager()
    
    let soundName: String = "writing"
    var player: AVAudioPlayer?
    
    func playEffect() {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: ".mp3") else { return }
                do {
                    player = try? AVAudioPlayer(contentsOf: url)
                    player?.play()
                }
    }
    
    func stopSoundEffect() {
        do {
            player?.stop()
        }
    }
}
