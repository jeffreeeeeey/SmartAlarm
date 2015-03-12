//
//  Alarm.swift
//  SmartAlarm
//
//  Created by 毕鸣 on 5/3/15.
//  Copyright (c) 2015 BM. All rights reserved.
//

import Foundation

class Alarm :NSObject {
    var date: NSDate
    var labelText = "Alarm"
    var repeat: [String] = []
    var useHolidays = false
    var sound = ""
    
    init(date: NSDate) {
        self.date = date
    }
    
    init(date: NSDate, labelText: String, repeat: [String], useHolidays: Bool, sound: String) {
        
        self.date = date
        self.labelText = labelText
        self.repeat = repeat
        self.useHolidays = useHolidays
        self.sound = sound
    }
}