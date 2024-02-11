//
//  PomodoroMenuBarApp.swift
//  PomodoroMenuBar
//
//  Created by Yiğithan Sönmez on 17.01.2023.
//

import SwiftUI

@main
struct PomodoroMenuBarApp: App {
    var body: some Scene {
        WindowGroup {
        }
    }
    
    init(){
        NSApplication.shared.setActivationPolicy(.accessory)
    }
    
    // Connecting App Delegate
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
}

// Menu Bar Button and Pop Over Menu Implementation
class AppDelegate: NSObject, NSApplicationDelegate{
    
    // Status Bar Item
    var statusItem: NSStatusItem?
    // PopOver
    var popOver = NSPopover()
    
    func applicationDidFinishLaunching(_ notification: Notification){
        let menuView = HomeView()
        
        // creating PopOver
        popOver.behavior = .transient
        popOver.animates = true
        
        // Setting Empty View Controller
        // and Setting Views as SwiftUI View
        // with the help of Hosting Controller
        popOver.contentViewController = NSViewController()
        popOver.contentViewController?.view = NSHostingView(rootView: menuView)
        
        // Creating Status Bar Button
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let menuButton = statusItem?.button{
            if let image = NSImage(named: "AppIcon"){
                image.size = NSSize(width: 24, height: 24)
                image.isTemplate = true
                menuButton.image = image
                menuButton.action = #selector(menuBarButtonClicked)
                menuButton.sendAction(on: [.leftMouseUp, .rightMouseUp])
            } else{
                print("Error Loading the Image")
            }
            
            PomodoroTimerViewModel.shared.setup(appDelegate: self)
        }
    }
    
    // Button Action
    @objc func menuBarButtonClicked(_ sender: NSStatusBarButton) {
        let event = NSApp.currentEvent!
        
        if event.type == NSEvent.EventType.rightMouseUp {
            PomodoroTimerViewModel.shared.toggleStartStop()
        } else {
            // showing PopOver
            if let menuButton = statusItem?.button{
                self.popOver.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: NSRectEdge.minY)
            }
        }
    }
}
