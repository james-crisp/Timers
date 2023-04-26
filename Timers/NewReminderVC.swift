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
    @IBAction func titleField(_ sender: NSTextField) {
    }
    @IBAction func descriptionField(_ sender: NSTextField) {
    }
    @IBAction func dateField(_ sender: NSDatePicker) {
    }
    
    @IBAction func submitButton(_ sender: NSButton) {
    }
    
}
