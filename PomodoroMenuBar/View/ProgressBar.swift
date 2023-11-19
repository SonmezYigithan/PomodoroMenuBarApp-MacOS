//
//  ProgressBar.swift
//  PomodoroMenuBar
//
//  Created by Yiğithan Sönmez on 18.11.2023.
//

import SwiftUI

struct ProgressBar: View {
    @StateObject var pomodoroTimer: PomodoroTimerViewModel
    
    var body: some View{
//        let colorBlue = Color(red: 0.231, green: 0.509, blue: 0.968)
        let colorGray = Color(red: 0.451, green: 0.451, blue: 0.451)
        let passedCircleProgress = pomodoroTimer.progress - 0.01
        
        ZStack{
            // Background Circle
            Circle()
                // 59, 130, 247
                .stroke(colorGray,lineWidth: 6)
                .frame(width: 150, height: 150)
            
            // Blue Passed Circle
            Circle()
                // 59, 130, 247
                .trim(from: 0, to: passedCircleProgress)
                .rotation(Angle(degrees: 270))
                .stroke(Color(red: 1, green: 1, blue: 1),lineWidth: 6)
                .frame(width: 150, height: 150)
            
            // Knob
            GeometryReader { proxy in
                let size = proxy.size

                Circle()
                    .fill(Color.white)
                    .frame(width: 15,height: 15)
                    .frame(width: size.width, height: size.height, alignment: .center)
                    .offset(y: -size.height / 2)
                    .rotationEffect(Angle(degrees: pomodoroTimer.progress * 360))
            }
            .frame(width: 150, height: 150)
                
            let minutes = pomodoroTimer.time / 60
            let seconds = pomodoroTimer.time % 60
            
            Text("\(minutes):\(String(format: "%02d", seconds))")
//                .colorInvert()
                .font(.system(size: 30, weight: .light))
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

