//
//  PomodoroTimer.swift
//  PomodoroMenuBar
//
//  Created by Yiğithan Sönmez on 17.11.2023.
//

import SwiftUI
import AVFoundation

enum IconState {
    case started
    case stopped
}

class PomodoroTimerViewModel: ObservableObject {
    static let shared = PomodoroTimerViewModel(time: 1500)
    
    @Published var time: Int
    @Published var progress: Double
    @Published var countDownTime: Int
    @Published var isTimerActive: Bool
    
    var appDelegate: AppDelegate?
    var timer: Timer?
    var audioPlayer: AVAudioPlayer!
    
    init(time: Int) {
        self.time = time
        progress = 0
        countDownTime = time
        isTimerActive = false
    }
    
    func start() {
        if isTimerActive {
            return
        }
        
        print("Timer Started")
        
        isTimerActive = true
        updateIconColor(iconState: .started)
        updateIconText()
        
        if timer == nil {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                if self.time > 0 {
                    self.time -= 1
                    self.progress = 1 - Double(self.time) / Double(self.countDownTime)
                }
                if self.time == 0{
                    // Timer ended
                    playSound(key: "completed_1")
                }
                self.updateIconText()
            }
        }
    }
    
    func stop() {
        print("Timer Stopped")
        
        timer?.invalidate()
        timer = nil
        updateIconColor(iconState: .stopped)
        isTimerActive = false
    }
    
    func toggleStartStop() {
        if isTimerActive {
            stop()
        }else {
            start()
        }
    }
    
    func restart() {
        print("Timer Restarted")
        stop()
        progress = 0
        time = self.countDownTime
        updateIconText()
    }
    
    func updateTime(newTime: Int){
        self.countDownTime = newTime
        restart()
    }
    
    // Shows time on Menu Bar Icon
    private func updateIconText() {
        let minutes = self.time / 60
        let seconds = self.time % 60
        
        if let button = appDelegate?.statusItem?.button {
            let formattedTime = String(format: "%02d:%02d", minutes, seconds)
            button.title = "\(formattedTime)  " // Add spaces for separation
        }
    }
    
    private func updateIconColor(iconState: IconState) {
        guard let currentImage = appDelegate?.statusItem?.button?.image else {
            return
        }
        
        var tintedImage = currentImage
        if iconState == .stopped {
            tintedImage.isTemplate = true
        }else {
            tintedImage = currentImage.setColor(color: .red)
        }
        
        appDelegate?.statusItem?.button?.image = tintedImage
    }
    
    func setup(appDelegate: AppDelegate){
        self.appDelegate = appDelegate
    }
}
