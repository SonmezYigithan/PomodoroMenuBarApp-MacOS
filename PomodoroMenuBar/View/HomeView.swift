//
//  MenuView.swift
//  PomodoroMenuBar
//
//  Created by Yiğithan Sönmez on 17.01.2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var pomodoroTimer = PomodoroTimerViewModel(time: 1500)
    @State private var isTimerActive = false
    @State var taskName = ""
    @FocusState private var taskNameFieldFocused: Bool
    
    @State private var isEditing: Bool = false
    
    var body: some View {
        VStack{
            ZStack{
                TextField("Type task Name..",text: $taskName)
                    .padding(.trailing,50)
                    .padding(.leading,10)
                    .textFieldStyle(PlainTextFieldStyle())
                
                HStack{
                    Spacer()
                    Button("X"){
                        NSApplication.shared.terminate(self)
                    }
                    .padding(.horizontal,15)
                }
            }
            .onTapGesture {
                self.isEditing = false
            }
            
            Divider()
                .padding(.horizontal,10)
                .padding(.bottom, 10)
            
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
                        .font(.system(size: 18))
                }
                .controlSize(.large)
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    self.pomodoroTimer.restart()
                }) {
                    Image(systemName: "return.left")
                        .padding(.horizontal, 18)
                        .padding(.vertical, 8)
                        .font(.system(size: 18))
                }
                .controlSize(.large)
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.bottom, 10)
            
        }
        .frame(width: 250, height: 280)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


