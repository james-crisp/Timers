//
//  NSMenu+Extension.swift
//  Timers
//
//  Created by James Crisp on 4/25/23.
//

import Foundation
import AppKit

extension NSMenu {
    func addSeparator() -> Void {
        addItem(.separator())
    }
    
    func addItems(_ items: NSMenuItem...) {
        for item in items {
            addItem(item)
        }
    }
}
