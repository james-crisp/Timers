//
//  Reminder.swift
//  Timers
//
//  Created by James Crisp on 4/26/23.
//

import Foundation

// We'll use this later
protocol ReminderDelegate {
    func onReminderFired(_ reminder: Reminder) -> Void
}


class Reminder {
    private typealias Notification = NSUserNotification
    
    var timer: Timer!
    var title: String!
    var descr: String?
    
    var tag: Int?
    var fireDate: Date
    var delegate: ReminderDelegate?
    
    
    init(_ title: String, description descr: String? = nil, fireOnDate date: Date, tag: Int? = nil) {
        self.title = title
        self.fireDate = date
        self.tag = tag
        self.descr = descr
        
        self.timer = Timer.scheduledTimer(
            withTimeInterval: date.timeIntervalSinceNow,
            repeats: false,
            block: { (t) in
                t.invalidate()
                
                let notification = Notification()
                
                notification.title = self.title
                notification.informativeText = self.descr
                notification.subtitle = "Hey! Your timer has fired"
                
                NSUserNotificationCenter.default.deliver(notification)
                
                // DELEGATION
                if let d = self.delegate {
                    d.onReminderFired(self)
                }
            }
        )
    }
}
