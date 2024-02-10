//
//  PomodoroTimer.swift
//  PomodoroMenuBar
//
//  Created by Yiğithan Sönmez on 17.11.2023.
//

import SwiftUI
import AVFoundation

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
        print("Timer Started")
        if isTimerActive {
            return
        }
        
        isTimerActive = true
        
        if timer == nil {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                if self.time > 0 {
                    self.time -= 1
                    self.progress = 1 - Double(self.time) / Double(self.countDownTime)
                    print("\(self.progress): \(self.time), \(self.countDownTime)")
                }
                if self.time == 0{
                    // Timer ended
                    playSound(key: "completed_1")
                }
                self.updateIcon()
            }
            
        }
    }
    
    func stop() {
        print("Timer Stopped")
        timer?.invalidate()
        timer = nil
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
    }
    
    func updateTime(newTime: Int){
        self.countDownTime = newTime
        restart()
    }
    
    // Shows time on Menu Bar Icon
    func updateIcon() {
        let minutes = self.time / 60
        let seconds = self.time % 60
        
        if let button = appDelegate?.statusItem?.button {
            let formattedTime = String(format: "%02d:%02d", minutes, seconds)
            button.title = "\(formattedTime)  " // Add spaces for separation
        }
    }
    
    func setup(appDelegate: AppDelegate){
        self.appDelegate = appDelegate
    }
}
