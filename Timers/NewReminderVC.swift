//
//  NewReminderVC.swift
//  Timers
//
//  Created by James Crisp on 4/26/23.
//

import Cocoa

protocol NewReminderVCDelegate {
    func onSubmit(_ sender: NSButton, reminder: Reminder) -> Void
}

class NewReminderVC: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
