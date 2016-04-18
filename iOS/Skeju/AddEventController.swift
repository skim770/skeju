//
//  AddEventController.swift
//  Skeju
//
//  Created by 김성식 on 3/30/16.
//  Copyright © 2016 GeorgiaTech. All rights reserved.
//

import Foundation
import UIKit

class AddEventController: UIViewController, UITextFieldDelegate {
    @IBOutlet var titleLocView: UIView!
    @IBOutlet var scheduleView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var titleTF: UITextField!
    @IBOutlet var locationTF: UITextField!
    @IBOutlet var allDaySwitch: UISwitch!
    @IBOutlet var startDateLabel: UILabel!
    @IBOutlet var startTimeLabel: UILabel!
    @IBOutlet var startBtn: UIButton!
    @IBOutlet var endDateLabel: UILabel!
    @IBOutlet var endTimeLabel: UILabel!
    @IBOutlet var endBtn: UIButton!
    @IBOutlet var availabilitySegCtrl: UISegmentedControl!
    @IBOutlet var scheduleBtn: UIButton!
    @IBOutlet var datePicker: UIDatePicker!
    
    let userDefault = NSUserDefaults()
    var userFID: String!
    var userName: String!
    var friendFID: String?
    var friendName: String?
    var datePickerTouched: Bool!
    var datePickerTouchedByStart: Bool?
    var startDate: NSDate?
    var endDate: NSDate?
    var startD: String?
    var startT: String?
    var endD: String?
    var endT: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 0.4)
        self.navigationController?.navigationBar.tintColor = UIColor.grayColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        self.navigationItem.title = "New Event"
        
        initUI()
        datePickerTouched = false
        
        userFID = userDefault.valueForKey("FBID") as! String
        userName = userDefault.valueForKey("FBName") as! String
        
        titleLabel.text = "Schedule with \(friendName!)"
        
        if startD != nil {
            startDateLabel.text = startD
            startTimeLabel.text = startT
            endDateLabel.text = endD
            endTimeLabel.text = endT
        }
    }
    
    @IBAction func scheduleBtnTouchUpInside(sender: AnyObject) {
        let identifier = titleTF.text
        let availability: String = String(availabilitySegCtrl.selectedSegmentIndex)
        let allDay: String = String(allDaySwitch.on)
        let isDetached: String = String("nil")
        let occurrenceDate: String = "nil"
        let status: String = String("1")
        
        let postReq = NSMutableURLRequest(URL: NSURL(string: "http://api-skeju.rhcloud.com/event")!)
        postReq.HTTPMethod = "POST"
        let postString = "eventIdentifier=\(identifier)&userId=\(userFID)&otherId=\(friendFID)&availability=\(availability)&startDate=\(startDate)&endDate=\(endDate)&allDay=\(allDay)&isDetached=\(isDetached)&occurenceDate=\(occurrenceDate)&organizer=nil&status=\(status)"
        postReq.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(postReq) { data, response, error in
            guard error == nil && data != nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response!)")
            }
        }
        task.resume()
    }
    
    @IBAction func startBtnTouchUpInside(sender: AnyObject) {
        self.datePicker.hidden = false
        self.datePickerTouched = true
        self.datePickerTouchedByStart = true
    }
    
    @IBAction func endBtnTouchUpInside(sender: AnyObject) {
        self.datePicker.hidden = false
        self.datePickerTouched = true
        self.datePickerTouchedByStart = false
    }
    
    func dismissDatePicker() {
        let dfDate = NSDateFormatter()
        dfDate.dateStyle = NSDateFormatterStyle.MediumStyle
        let dfTime = NSDateFormatter()
        dfTime.timeStyle = NSDateFormatterStyle.ShortStyle
        if datePickerTouchedByStart == true {
            startDateLabel.text = dfDate.stringFromDate(datePicker.date)
            startTimeLabel.text = dfTime.stringFromDate(datePicker.date)
            startDate = datePicker.date
        } else {
            endDateLabel.text = dfDate.stringFromDate(datePicker.date)
            endTimeLabel.text = dfTime.stringFromDate(datePicker.date)
            endDate = datePicker.date
        }
        datePicker.hidden = true
        datePickerTouched = false
    }
    
    func initUI() {
        titleLocView.clipsToBounds = false
        titleLocView.layer.masksToBounds = true
        titleLocView.layer.cornerRadius = 4
        
        scheduleView.clipsToBounds = false
        scheduleView.layer.masksToBounds = true
        scheduleView.layer.cornerRadius = 4
        
        scheduleBtn.layer.cornerRadius = 4
        
        titleTF.delegate = self
        locationTF.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let nextTag: NSInteger! = textField.tag + 1
        let nextResponder: UIResponder! = textField.superview?.viewWithTag(nextTag)
        if nextResponder != nil {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
        if datePickerTouched == true {
            dismissDatePicker()
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}