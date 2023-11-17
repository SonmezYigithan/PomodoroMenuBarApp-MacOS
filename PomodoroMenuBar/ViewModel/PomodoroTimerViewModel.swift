//
//  PomodoroTimer.swift
//  PomodoroMenuBar
//
//  Created by Yiğithan Sönmez on 17.11.2023.
//

import SwiftUI

class PomodoroTimerViewModel: ObservableObject {
    @Published var time: Int
    var timer: Timer?
    init(time: Int) {
        self.time = time
    }
    func start() {
        print("Timer Started")
        if timer == nil{
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                if self.time > 0 {
                    self.time -= 1
                }
            }
            updateIcon()
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
        self.time = 1500
    }
    
    func updateIcon() {
        let minutes = self.time / 60
        let statusBarButton = NSStatusBar.system.statusItem(withLength:NSStatusItem.variableLength)
        statusBarButton.button?.title = "\(minutes)"
    }
}
