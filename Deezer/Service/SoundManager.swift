//
//  SoundManager.swift
//  Deezer
//
//  Created by Hakan ERDOĞMUŞ on 26.10.2023.
//

import Foundation
import AVFoundation

class SoundManager {
    
    static let shared = SoundManager()
    
    var audioPlayer: AVPlayer?

    func playSound(sound: String){
        if let url = URL(string: sound) {
            self.audioPlayer = AVPlayer(url: url)
            print(url)
        }
    }
}
