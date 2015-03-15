//
//  EditAlarmViewController.swift
//  SmartAlarm
//
//  Created by 毕鸣 on 2/3/15.
//  Copyright (c) 2015 BM. All rights reserved.
//

import UIKit
import Foundation

class EditAlarmViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var timePicker: UIPickerView!
    
    @IBOutlet weak var settingsTable: UITableView!
    
    private var alarmsList: AlarmsList!
    private let hourComponent = 0
    private let minuteComponent = 1
    private let hours = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]
    private let minutes = ["00", "05", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55"]
    let cellIdentifier = "cell"
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        alarmsList = AlarmsList.sharedAlarmsList
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK- Set Alarm
    
    @IBAction func savePressed(sender: UIBarButtonItem) {
        let calendar = NSCalendar.currentCalendar()
        
        var date = NSDate()
        
        let hour = hours[self.timePicker.selectedRowInComponent(0)]
        let minute = minutes[self.timePicker.selectedRowInComponent(1)]
        
        let year = calendar.component(NSCalendarUnit.CalendarUnitYear, fromDate: date)
        let month = calendar.component(NSCalendarUnit.CalendarUnitMonth, fromDate: date)
        let day = calendar.component(NSCalendarUnit.CalendarUnitDay, fromDate: date)
        
        let dateComponent = NSDateComponents.init()
        dateComponent.year = year
        dateComponent.month = month
        dateComponent.day = day
        dateComponent.hour = (hour as NSString).integerValue
        dateComponent.minute = (minute as NSString).integerValue
        let GMTDate: NSDate! = calendar.dateFromComponents(dateComponent)
        
        // a formatter transfer the GMTime to local
        let dateFormater = NSDateFormatter.init()
        dateFormater.timeStyle = NSDateFormatterStyle.MediumStyle
        dateFormater.dateStyle = NSDateFormatterStyle.MediumStyle
        let gmtDateString = dateFormater.stringFromDate(GMTDate)

        println("alarm date: \(gmtDateString)")
        
        // add alarm to list 
        
        var dulplicate = false
        
        if alarmsList.alarmsList.count > 0 {
            for am in alarmsList.alarmsList {
                if(GMTDate.isEqualToDate(am.date)){
                    dulplicate = true
                    let message = "You select the same time"
                    let alert = UIAlertController(title: "Same Time", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                    let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                    alert.addAction(action)
                    presentViewController(alert, animated: true, completion: nil)
                }
            }
        }
        
        if dulplicate == false {
            
            var alarm: Alarm = Alarm(date: GMTDate)
            alarmsList.addAlarm(alarm)
            
        }
        
        
        
        /*
        let message = "You select \(hour) : \(minute)"
        let alert = UIAlertController(title: "select time", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Good", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        */
    }
    
    
    @IBAction func cancelPressed(sender: UIBarButtonItem) {
        let pre = self.presentingViewController as UIViewController!
        
        pre.dismissViewControllerAnimated(true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Picker Data Source Methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == hourComponent {
            return hours.count
        } else {
            return minutes.count
        }
    }
    
    //MARK: - Picker View Delegate Methods
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if component == hourComponent {
            return hours[row]
        } else {
            return minutes[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == 0 {
            return 50.0
        } else {
            return 50.0
        }
    }
    
    //MARK: - Table View Data Source Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? UITableViewCell
    
        // Configure the cell...
        if (cell == nil) {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
        if indexPath.row == 0 {
            cell!.textLabel!.text = "Repeat"
            cell!.detailTextLabel?.text = "Only Once"
        } else if indexPath.row == 1 {
            cell!.textLabel!.text = "Holidays"
        } else if indexPath.row == 2 {
            cell?.textLabel?.text = "Sound"
        }
        
    
        return cell!
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        if section == 0 {
            title = "settings"
        }
        return title
    }
    

}
