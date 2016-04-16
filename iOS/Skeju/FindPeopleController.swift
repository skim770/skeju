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
import FBSDKCoreKit

class FindPeopleController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var titleView: UIView!
    @IBOutlet var dayPlannerContainer: UIView!

    @IBOutlet var beginTimeView: UIView!
    @IBOutlet var endTimeView: UIView!
    @IBOutlet var foundFriendView: UIView!
    
    @IBOutlet var beginDate: UILabel!
    @IBOutlet var endDate: UILabel!
    @IBOutlet var beginTime: UIButton!
    @IBOutlet var endTime: UIButton!
    @IBOutlet var beginDay: UILabel!
    @IBOutlet var endDay: UILabel!
    var beginAll: String = ""
    var endAll: String = ""
    
    @IBOutlet var fbFriendList: UITableView!
    var fbFriendsListData = [(name: String, id: String, profile: UIImage)]()
    let userDefault = NSUserDefaults()
    
    
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
        dateFormatter.dateFormat = "MM:dd:yyyy:h:m"
        beginAll = dateFormatter.stringFromDate(NSDate())
        endAll = dateFormatter.stringFromDate(NSDate())
        
        changeDate(beginDay, date: beginDate, time: beginTime, datePicked: NSDate())
        changeDate(endDay, date: endDate, time: endTime, datePicked: NSDate())
        
        fbFriendList.delegate = self
        fbFriendList.dataSource = self
        
        getFriends()
    }
    
    func timeChange(i: Bool, pos: CGFloat) {
        datePickerContainer.frame = CGRectMake(pos, self.view.frame.height/2, 320.0, 200.0)
        datePickerContainer.backgroundColor = UIColor.whiteColor()
        datePickerContainer.layer.cornerRadius = 15
        
        let pickerSize : CGSize = datePicker.sizeThatFits(CGSizeZero)
        datePicker.frame = CGRectMake(0.0, 20, pickerSize.width, 180)
        datePicker.datePickerMode = UIDatePickerMode.DateAndTime
        datePickerContainer.addSubview(datePicker)
        
        let doneButton = UIButton()
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        if i {
            doneButton.addTarget(self, action: Selector("dismissPickerBegin:"), forControlEvents: UIControlEvents.TouchUpInside)
        } else {
            doneButton.addTarget(self, action: Selector("dismissPickerEnd:"), forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        doneButton.frame = CGRectMake(250.0, 5.0, 70.0, 37.0)
        
        datePickerContainer.addSubview(doneButton)
        
        self.view.addSubview(datePickerContainer)
        
    }
    
    func changeDate(day: UILabel, date: UILabel, time: UIButton, datePicked: NSDate) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "cccc"
        day.text = dateFormatter.stringFromDate(datePicked)
        dateFormatter.dateFormat = "MMM dd"
        date.text = dateFormatter.stringFromDate(datePicked)
        dateFormatter.dateFormat = "h:mm a"
        time.setTitle(dateFormatter.stringFromDate(datePicked), forState: .Normal)
    }
    
    func dateCheck() -> Bool {
        let endDates = endAll.componentsSeparatedByString(":")
        let beginDates = beginAll.componentsSeparatedByString(":")
        
        if beginDates[2] > endDates[2] {
            return true
        } else if beginDates[0] > endDates[0] {
            return true
        } else if beginDates[1] > endDates[1] {
            return true
        } else if beginDates[3] > endDates[3] {
            return true
        } else if beginDates[4] > endDates[4] {
            return true
        } else {
            return false
        }
    }
    
    func dismissPickerBegin(sender: UIButton) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM:dd:yyyy:h:m"
        beginAll = dateFormatter.stringFromDate(datePicker.date)
        changeDate(beginDay, date: beginDate, time: beginTime, datePicked: datePicker.date)
        
        for view in self.datePickerContainer.subviews {
            view.removeFromSuperview()
        }
        datePickerContainer.removeFromSuperview()
        
        if dateCheck() {
            endAll = dateFormatter.stringFromDate(datePicker.date)
            changeDate(endDay, date: endDate, time: endTime, datePicked: datePicker.date)
        }
        getFriends()
    }
    
    func dismissPickerEnd(sender: UIButton) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd:MM:yyyy:HH:mm"
        endAll = dateFormatter.stringFromDate(datePicker.date)
        changeDate(endDay, date: endDate, time: endTime, datePicked: datePicker.date)
        
        for view in self.datePickerContainer.subviews {
            view.removeFromSuperview()
        }
        datePickerContainer.removeFromSuperview()

        if dateCheck() {
            beginAll = dateFormatter.stringFromDate(datePicker.date)
            changeDate(beginDay, date: beginDate, time: beginTime, datePicked: datePicker.date)
        }
        getFriends()
    }
    
    func getFriends() {
        let fbGraphRequest = FBSDKGraphRequest(graphPath: "me/friends", parameters: nil, HTTPMethod: "GET")
        fbGraphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            if error != nil {
                print("Error: \(error)")
            } else {
                let friendsDict = result as! NSDictionary
                let data : NSArray = friendsDict.objectForKey("data") as! NSArray
                
                self.fbFriendsListData.removeAll()
                
                for i in 0..<data.count {
                    let rand = arc4random_uniform(2)
                    if rand == 1 {
                        let valueDict : NSDictionary = data[i] as! NSDictionary
                        let fname = valueDict.objectForKey("name") as! String
                        let fid = valueDict.objectForKey("id") as! String
                        
                        let fbPicURL = "https://graph.facebook.com/\(fid)/picture?type=normal&return_ssl_resources=1"
                        let fbRequest = NSURL(string: fbPicURL)
                        let fbProfilePicData = NSData(contentsOfURL: fbRequest!)
                        let fbProfilePic = UIImage(data: fbProfilePicData!)
                        
                        self.fbFriendsListData.append((name: fname, id: fid, profile: fbProfilePic!))
                    }
                }
                
                self.fbFriendList.reloadData()
            }
        })
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = fbFriendList.dequeueReusableCellWithIdentifier("FBFriendCell")! as UITableViewCell
        cell.textLabel?.text = fbFriendsListData[indexPath.row].name
        cell.imageView?.image = fbFriendsListData[indexPath.row].profile
        cell.imageView?.layer.cornerRadius = 5
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fbFriendsListData.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(50)
    }
}