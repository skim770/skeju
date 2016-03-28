//
//  FindPeopleController.swift
//  Skeju
//
//  Created by Sung Kim on 3/6/16.
//  Copyright © 2016 GeorgiaTech. All rights reserved.
//

import Foundation
import UIKit
import EventKit

class FindPeopleController: UIViewController {
    
    @IBOutlet var titleView: UIView!
    @IBOutlet var dayPlannerContainer: UIView!

    @IBOutlet var beginTimeView: UIView!
    @IBOutlet var endTimeView: UIView!
    @IBOutlet var foundFriendView: UIView!
    
    @IBOutlet weak var beginDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var beginTime: UIButton!
    @IBOutlet weak var endTime: UIButton!
    @IBOutlet weak var beginDay: UILabel!
    @IBOutlet weak var endDay: UILabel!
    
    let screenWidth = UIScreen.mainScreen().bounds.width
    let screenHeight = UIScreen.mainScreen().bounds.height
    
    var dayPlannerController: DayPlannerController!

    let datePickerContainer = UIView()
    let datePicker : UIDatePicker = UIDatePicker()
    
    @IBAction func beginChange(sender: AnyObject) {
        
        timeChange(true, pos: beginTime.center.x - beginTime.frame.width/2)
    }
    
    @IBAction func endChange(sender: AnyObject) {
        timeChange(false, pos: endTime.center.x - endTime.frame.width/2)
    }
    
    func timeChange(i: Bool, pos: CGFloat) {
        datePickerContainer.frame = CGRectMake(pos, self.view.frame.height/2, 320.0, 200.0)
        datePickerContainer.backgroundColor = UIColor.whiteColor()
        datePickerContainer.layer.cornerRadius = 15
        
        let pickerSize : CGSize = datePicker.sizeThatFits(CGSizeZero)
        datePicker.frame = CGRectMake(0.0, 20, pickerSize.width, 180)
        datePicker.setDate(NSDate(), animated: true)
        datePicker.maximumDate = NSDate()
        datePicker.datePickerMode = UIDatePickerMode.DateAndTime
        datePickerContainer.addSubview(datePicker)
        
        let doneButton = UIButton()
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        if i {
            doneButton.addTarget(self, action: Selector("dismissPickerBegin:"), forControlEvents: UIControlEvents.TouchUpInside)
        } else {
            doneButton.addTarget(self, action: Selector("dismissPickerEnd:"), forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        doneButton.frame = CGRectMake(250.0, 5.0, 70.0, 37.0)
        
        datePickerContainer.addSubview(doneButton)
        
        self.view.addSubview(datePickerContainer)
        
    }
    
    func dismissPickerBegin(sender: UIButton) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "cccc"
        beginDay.text = dateFormatter.stringFromDate(datePicker.date)
        dateFormatter.dateFormat = "MMM dd"
        beginDate.text = dateFormatter.stringFromDate(datePicker.date)
        dateFormatter.dateFormat = "h:mm a"
        beginTime.setTitle(dateFormatter.stringFromDate(datePicker.date), forState: .Normal)
        for view in self.datePickerContainer.subviews {
            view.removeFromSuperview()
        }
        datePickerContainer.removeFromSuperview()
    }
    
    func dismissPickerEnd(sender: UIButton) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "cccc"
        endDay.text = dateFormatter.stringFromDate(datePicker.date)
        dateFormatter.dateFormat = "MMM dd"
        endDate.text = dateFormatter.stringFromDate(datePicker.date)
        dateFormatter.dateFormat = "h:mm a"
        endTime.setTitle(dateFormatter.stringFromDate(datePicker.date), forState: .Normal)
        for view in self.datePickerContainer.subviews {
            view.removeFromSuperview()
        }
        datePickerContainer.removeFromSuperview()
    }
   
    
    
    override func viewDidLoad() {
        //self.scene.scaleMode = SKSceneScaleMode.ResizeFill
        
        super.viewDidLoad()
        dayPlannerController = DayPlannerController(eventStore: EKEventStore())
        dayPlannerController.calendar = NSCalendar.currentCalendar()
        
        self.addChildViewController(dayPlannerController)
        self.dayPlannerContainer.addSubview(dayPlannerController.view)
        dayPlannerController.view.frame = self.dayPlannerContainer.bounds
        dayPlannerController.didMoveToParentViewController(self)

        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "cccc"
        beginDay.text = dateFormatter.stringFromDate(NSDate())
        endDay.text = dateFormatter.stringFromDate(NSDate())

        dateFormatter.dateFormat = "MMM dd"
        beginDate.text = dateFormatter.stringFromDate(NSDate())
        endDate.text = dateFormatter.stringFromDate(NSDate())
        
        dateFormatter.dateFormat = "h:mm a"
        beginTime.setTitle(dateFormatter.stringFromDate(NSDate()), forState: .Normal)
        endTime.setTitle(dateFormatter.stringFromDate(NSDate()), forState: .Normal)
        
        /*
        beginTime.addTarget(self, action: Selector("dataPickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        endTime.addTarget(self, action: Selector("dataPickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)*/
        
    }
    
    
    
    /*func datePickerChanged(datePicker:UIDatePicker) {
        var dateFormatter = NSDateFormatter()
    
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        var strDate = dateFormatter.stringFromDate(datePicker.date)
        dateLabel.text = strDate
    }*/
}

/*
// Get Friend List
FBRequestConnection.startForMyFriendsWithCompletionHandler({ (connection, result, error: NSError!) -> Void in
if error == nil {
var friendObjects = result["data"] as [NSDictionary]
for friendObject in friendObjects {
println(friendObject["id"] as NSString)
}
println("\(friendObjects.count)")
} else {
println("Error requesting friends list form facebook")
println("\(error)")
}
})
*/