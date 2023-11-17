//
//  MenuView.swift
//  PomodoroMenuBar
//
//  Created by Yiğithan Sönmez on 17.01.2023.
//

import SwiftUI

struct MenuView: View {
    @StateObject var pomodoroTimer = PomodoroTimerViewModel(time: 1500)
    
    var body: some View {
        VStack{
            ZStack{
                Text("Focus Time")
                    .bold()
                
                HStack{
                    Spacer()
                    Button("X"){
                        NSApplication.shared.terminate(self)
                    }
                    .padding(.horizontal,15)
                }
            }
            .padding(.bottom, 5)
            
            ZStack{
                Circle()
                    .fill(.white)
                    .frame(width: 150, height: 150)
                    
                let minutes = pomodoroTimer.time / 60
                let seconds = pomodoroTimer.time % 60
                
                Text("\(minutes):\(String(format: "%02d", seconds))")
                    .colorInvert()
                    .font(.system(size: 30, weight: .light))
            }
            .padding(.bottom,10)
            
            HStack{
                Button("Start") {
                    self.pomodoroTimer.start()
                }
                .cornerRadius(10)
                .controlSize(.large)
                
                Button("Stop") {
                    self.pomodoroTimer.stop()
                }
                .cornerRadius(10)
                .controlSize(.large)
                
                Button("Restart") {
                    self.pomodoroTimer.restart()
                }
                .cornerRadius(10)
                .controlSize(.large)
            }
            .padding(.bottom, 10)
            
        }
        .frame(width: 300, height: 280)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}


