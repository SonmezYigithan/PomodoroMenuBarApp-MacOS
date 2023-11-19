//
//  PomodoroTimer.swift
//  PomodoroMenuBar
//
//  Created by Yiğithan Sönmez on 17.11.2023.
//

import SwiftUI

class PomodoroTimerViewModel: ObservableObject {
    @Published var time: Int
    @Published var progress: Double
    @Published var countDownTime: Int
    var timer: Timer?
    
    init(time: Int) {
        self.time = time
        self.progress = 0
        self.countDownTime = time
    }
    func start() {
        print("Timer Started")
        if timer == nil{
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                if self.time > 0 {
                    self.time -= 1
                    self.progress = 1 - Double(self.time) / Double(self.countDownTime)
                    print("\(self.progress): \(self.time), \(self.countDownTime)")
                }
//                self.updateIcon()
            }
            
        }
    }
    func stop() {
        print("Timer Stopped")
        self.timer?.invalidate()
        self.timer = nil
    }
    func restart() {
        print("Timer Restarted")
        self.stop()
        self.progress = 0
        self.time = self.countDownTime
    }
    func updateTime(newTime: Int){
        self.countDownTime = newTime
        restart()
    }
    
    // to show time on Menu Bar Icon
    func updateIcon() {
        let minutes = self.time / 60
        let statusBarButton = NSStatusBar.system.statusItem(withLength:NSStatusItem.variableLength)
        statusBarButton.button?.title = "\(minutes)"
    }
}
