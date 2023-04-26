//
//  AppDelegate.swift
//  Timers
//
//  Created by James Crisp on 4/25/23.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    var timer: Timer? = nil
    var reminders: [Reminder] = []
    
    func applicationWillFinishLaunching(_ notification: Notification) {
       if Preferences.firstRunGone == false {
           // This will be executed on first run
           Preferences.firstRunGone = true
           
           // Set preferences to their defaults
           Preferences.restore()
       }
        
        DockIcon.standard.setVisibility(Preferences.showDockIcon)
   }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        guard let statusButton = statusBarItem.button else { return }
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        statusButton.title = String(hour) + ":" + String(minutes) + ":" + String(seconds)
        
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateStatusText),
            userInfo: nil,
            repeats: true
        )
        // Run even if highlighted
//        RunLoop.main.add(timer!, forMode: .common)
        
        let statusMenu: NSMenu = NSMenu()
        
        // Displays good morning or evening depending on time of day
//        statusMenu.addItem(withTitle: "Good \(Date.now.isMorning ? "Morning" : "Evening")", action: nil, keyEquivalent: "")
//        statusMenu.addSeparator()
        
        let toggleFlashingSeparatorsItem: NSMenuItem = {
            let item = NSMenuItem(
                title: "Flashing separators",
                action: #selector(toggleFlashingSeparators),
                keyEquivalent: ""
            )
            
            item.tag = 1
            item.target = self
            item.state = Preferences.useFlashDots.stateValue
            
            return item
        }()
        
        let toggleDockIconItem: NSMenuItem = {
            let item = NSMenuItem(
                title: "Toggle Dock Icon",
                action: #selector(toggleDockIcon),
                keyEquivalent: ""
            )
            
            item.tag = 2
            item.target = self
            item.state = Preferences.showDockIcon.stateValue
            
            return item
        }()
        
        let toggleSecondsItem: NSMenuItem = {
            let item = NSMenuItem(
                title: "Show seconds",
                action: #selector(toggleSeconds),
                keyEquivalent: ""
            )
            
            item.tag = 3
            item.target = self
            item.state = Preferences.showSeconds.stateValue
            
            return item
        }()
        
        let toggleTimerItem: NSMenuItem = {
            let item = NSMenuItem(
                title: "Timer1",
                action: #selector(toggleTimer),
                keyEquivalent: ""
            )
            
            item.tag = 3
            item.target = self
            item.state = Preferences.showTimer.stateValue
            
            return item
        }()
        
        let quitApplicationItem: NSMenuItem = {
            let item = NSMenuItem(title: "Quit", action: #selector(terminate), keyEquivalent: "q")
            item.target = self
            
            return item
        }()
        
        
        let remindersItem: NSMenuItem = {
            let item = NSMenuItem(title: "Reminders", action: nil, keyEquivalent: "")
            item.tag = 5

            let menu = NSMenu()

            for reminder in self.reminders {
                menu.addItem(.init(title: reminder.title, action: nil, keyEquivalent: ""))
            }

            item.isEnabled = reminders.count > 0

            return item
        }()
        
        statusMenu.addItems(
            toggleFlashingSeparatorsItem,
            toggleDockIconItem,
            
            .separator(),
            
            toggleSecondsItem,
            
            .separator(),
            
            quitApplicationItem
        )
        
        statusBarItem.menu = statusMenu
    }
}

//    func applicationWillTerminate(_ aNotification: Notification) {
//        // Insert code here to tear down your application
//    }

/*
 * -----------------------
 * MARK: - Actions
 * ------------------------
 */
extension AppDelegate {
    @objc
    func updateStatusText(_ sender: Timer) {
        guard let statusButton = statusBarItem.button else { return }
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        statusButton.title = String(hour) + ":" + String(minutes) + ":" + String(seconds)
        print(String(hour) + ":" + String(minutes) + ":" + String(seconds))
    }
    
    @objc
    func toggleFlashingSeparators(_ sender: NSMenuItem) {
        Preferences.useFlashDots = !Preferences.useFlashDots
        
        if let menu = statusBarItem.menu, let item = menu.item(withTag: 1) {
            item.state = Preferences.useFlashDots.stateValue
        }
    }
    
    
    @objc
    func toggleDockIcon(_ sender: NSMenuItem) {
        Preferences.showDockIcon = !Preferences.showDockIcon

        DockIcon.standard.setVisibility(Preferences.showDockIcon)

        if let menu = statusBarItem.menu, let item = menu.item(withTag: 2) {
            item.state = Preferences.showDockIcon.stateValue
        }
    }
    
    @objc
    func toggleSeconds(_ sender: NSMenuItem) {
        Preferences.showSeconds = !Preferences.showSeconds
        
        if let menu = statusBarItem.menu, let item = menu.item(withTag: 3) {
            item.title = "Show seconds"
            item.state = Preferences.showSeconds.stateValue
        }
    }
    
    @objc
    func toggleTimer(_ sender: NSMenuItem) {
        Preferences.showTimer = !Preferences.showTimer
        
        if let menu = statusBarItem.menu, let item = menu.item(withTag: 3) {
            item.title = "Show Timer"
            item.state = Preferences.showTimer.stateValue
        }
    }
    
    @objc
    func terminate(_ sender: NSMenuItem) {
        NSApp.terminate(sender)
    }
}
    
//    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
//        return true
//    }




