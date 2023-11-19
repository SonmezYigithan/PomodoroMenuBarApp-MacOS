//
//  MenuView.swift
//  PomodoroMenuBar
//
//  Created by Yiğithan Sönmez on 17.01.2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var pomodoroTimer = PomodoroTimerViewModel(time: 10)
    @State private var isTimerActive = false
    
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
            .padding(.top,15)
            
            Divider()
                .padding(.horizontal,10)
            
            ProgressBar(pomodoroTimer: pomodoroTimer)
            
            HStack{
                Button(action: {
                    print("isTimerActive: \(isTimerActive)")
                    if isTimerActive{
                        self.pomodoroTimer.stop()
                        isTimerActive = false
                    }
                    else{
                        self.pomodoroTimer.start()
                        isTimerActive = true
                    }
                }) {
                    Image(systemName: isTimerActive ? "pause.fill" : "play.fill")
                        .padding(.horizontal, 18)
                        .padding(.vertical, 8)
                }
                .cornerRadius(10)
                .controlSize(.large)
                
                Button(action: {
                    self.pomodoroTimer.restart()
                }) {
                    Image(systemName: "return.left")
                        .padding(.horizontal, 18)
                        .padding(.vertical, 8)
                        .font(.system(size: 12))
                }
                .cornerRadius(10)
                .controlSize(.large)
            }
            .padding(.bottom, 10)
            
        }
        .frame(width: 280, height: 280)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


