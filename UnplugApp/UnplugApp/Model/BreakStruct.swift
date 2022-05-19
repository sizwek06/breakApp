//
//  BreakStruct.swift
//  UnplugApp
//
//  Created by Sizwe Khathi on 2022/05/18.
//

import Foundation

struct BreakItem {
    let name: String
    let breakLength: String
    let timeOfDay: String
    let reminder: String
    let colour: String
    
    init(name: String, breakLength: String, timeOfDay: String, reminder: String, colour: String) {
        self.name = name
        self.breakLength = breakLength
        self.colour = colour
        self.reminder = reminder
        self.timeOfDay = timeOfDay
    }
}

