//
//  MenuView.swift
//  PomodoroMenuBar
//
//  Created by Yiğithan Sönmez on 17.01.2023.
//

import SwiftUI

struct HomeView: View {
    enum focusType{
        case taskNameField
        case timeField
    }
    
    @StateObject var timer = PomodoroTimerViewModel.shared
    @State var taskName = ""
    @FocusState var focusField: Bool?
    @State var isTextFieldInteractable = true
    
    var body: some View {
        VStack{
            ZStack{
                TextField("Type task Name..",text: $taskName)
                    .focused($focusField, equals: true)
                    .padding(.trailing,50)
                    .padding(.leading,10)
                    .textFieldStyle(PlainTextFieldStyle())
                    .onSubmit {
                        focusField = nil
                        isTextFieldInteractable = false
                    }
                    .disabled(!isTextFieldInteractable)
                    .foregroundColor(.primary)
                
                HStack{
                    Spacer()
                    Button("X"){
                        NSApplication.shared.terminate(self)
                    }
                    .padding(.horizontal,15)
                }
            }
            
            
            Divider()
                .padding(.horizontal,10)
                .padding(.bottom, 10)
            
            ProgressBar(pomodoroTimer: timer)
            
            HStack{
                Button(action: {
                    timer.toggleStartStop()
                }) {
                    Image(systemName: timer.isTimerActive ? "pause.fill" : "play.fill")
                        .padding(.horizontal, 18)
                        .padding(.vertical, 8)
                        .font(.system(size: 18))
                }
                .controlSize(.large)
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    self.timer.restart()
                    isTextFieldInteractable = true
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


