//
//  AlarmsList.swift
//  SmartAlarm
//
//  Created by 毕鸣 on 13/3/15.
//  Copyright (c) 2015 BM. All rights reserved.
//

import Foundation

class AlarmsList: NSObject{
    
    class var sharedAlarmsList: AlarmsList {
        struct Static {
            static let instance: AlarmsList = AlarmsList()
        }
        return Static.instance
    }
    
    private(set) var alarmsList:[Alarm]
    
    override init() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let storedAlarmsList = defaults.objectForKey("alarmsList") as? [Alarm]
        alarmsList = storedAlarmsList != nil ? storedAlarmsList! : []
    }

    func addAlarm(alarm: Alarm) {
        alarmsList.append(alarm)
        saveAlarmList()
        println("alarm added")
    }
    
    private func saveAlarmList() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(alarmsList, forKey: "alarmsList")
        defaults.synchronize()
        println("count: \(alarmsList.count)")
    }
}
