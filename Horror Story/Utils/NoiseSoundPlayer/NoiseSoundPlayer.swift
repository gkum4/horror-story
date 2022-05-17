//
//  NoiseSoundPlayer.swift
//  Horror Story
//
//  Created by Gustavo Kumasawa on 17/05/22.
//

import AVFoundation

class NoiseSoundPlayer {
    private var player: AVAudioPlayer?
    static let shared = NoiseSoundPlayer()
    
    func startSound() {
        if let bundle = Bundle.main.path(forResource: "ruido", ofType: "wav") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            
            do {
                player = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = player else { return }
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                
                audioPlayer.play()
                audioPlayer.volume = 0.03
                
            } catch {
                print(error)
            }
        }
    }
    
    func stopBackgroundMusic() {
        guard let audioPlayer = player else { return }
        audioPlayer.stop()
    }
}
