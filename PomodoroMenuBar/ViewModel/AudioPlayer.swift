//
//  AudioPlayer.swift
//  PomodoroMenuBar
//
//  Created by Yiğithan Sönmez on 20.11.2023.
//

import Foundation
import AVFAudio

var audioPlayer: AVAudioPlayer!

func playSound(key: String) {
    let url = Bundle.main.url(forResource: key, withExtension: ".mp3")
    
    guard url != nil else{
        return
    }
    
    do {
        audioPlayer = try AVAudioPlayer(contentsOf: url!)
        audioPlayer?.play()
    } catch {
        print("\(error)")
    }
}
