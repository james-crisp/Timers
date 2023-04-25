//
//  Bool+Extension.swift
//  Timers
//
//  Created by James Crisp on 4/25/23.
//

import Foundation
import AppKit

extension Bool {
    var stateValue: NSControl.StateValue {
        return self.toStateValue()
    }
    
    private func toStateValue() -> NSControl.StateValue {
        return self ? .on : .off
    }
}
