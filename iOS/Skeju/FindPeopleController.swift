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
    @IBOutlet var datePickerContainerView: UIView!
    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var doneButton: UIButton!
    
    @IBOutlet var beginDate: UILabel!
    @IBOutlet var endDate: UILabel!
    @IBOutlet var beginTime: UIButton!
    @IBOutlet var endTime: UIButton!
    @IBOutlet var beginDay: UILabel!
    @IBOutlet var endDay: UILabel!
    var beginAll: String = ""
    var endAll: String = ""
    var begin: NSDate?
    var end: NSDate?
    var isBegin: Bool = true
    
    @IBOutlet var fbFriendList: UITableView!
    var fbFriendsListData = [(name: String, id: String, profile: UIImage)]()
    var friendName: String!
    var friendFID: String!
    let userDefault = NSUserDefaults()
    
    
    let screenWidth = UIScreen.mainScreen().bounds.width
    let screenHeight = UIScreen.mainScreen().bounds.height
    
    var dayPlannerController: DayPlannerController!
    
    @IBAction func beginChange(sender: AnyObject) {
        datePickerContainerView.hidden = false
        isBegin = true
    }
    
    @IBAction func endChange(sender: AnyObject) {
        datePickerContainerView.hidden = false
        isBegin = false
    }
    
    @IBAction func timeChange(sender: AnyObject) {
        if isBegin {
            dismissPickerBegin()
        } else {
            dismissPickerEnd()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        
        dayPlannerController = DayPlannerController(eventStore: EKEventStore())
        dayPlannerController.calendar = NSCalendar.currentCalendar()
        
        self.addChildViewController(dayPlannerController)
        self.dayPlannerContainer.addSubview(dayPlannerController.view)
        dayPlannerController.view.frame = self.dayPlannerContainer.bounds
        dayPlannerController.didMoveToParentViewController(self)
        
        datePickerContainerView.hidden = true
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM:dd:yyyy:h:m"
        beginAll = dateFormatter.stringFromDate(NSDate())
        endAll = dateFormatter.stringFromDate(NSDate())
        
        begin = NSDate()
        end = NSDate()
        
        changeDate(beginDay, date: beginDate, time: beginTime, datePicked: NSDate())
        changeDate(endDay, date: endDate, time: endTime, datePicked: NSDate())
        
        fbFriendList.delegate = self
        fbFriendList.dataSource = self
        
        getFriends()
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
        let endArray = endAll.componentsSeparatedByString(":")
        let beginArray = beginAll.componentsSeparatedByString(":")
        
        if beginArray[2] > endArray[2] {
            return true
        } else if beginArray[0] > endArray[0] {
            return true
        } else if beginArray[1] > endArray[1] {
            return true
        } else if beginArray[3] > endArray[3] {
            return true
        } else if beginArray[4] > endArray[4] {
            return true
        } else {
            return false
        }
    }
    
    func dismissPickerBegin() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM:dd:yyyy:h:m"
        beginAll = dateFormatter.stringFromDate(datePicker.date)
        begin = datePicker.date
        changeDate(beginDay, date: beginDate, time: beginTime, datePicked: datePicker.date)
        
        datePickerContainerView.hidden = true
        
        if dateCheck() {
            endAll = dateFormatter.stringFromDate(datePicker.date)
            changeDate(endDay, date: endDate, time: endTime, datePicked: datePicker.date)
        }
        getFriends()
    }
    
    func dismissPickerEnd() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM:dd:yyyy:h:m"
        endAll = dateFormatter.stringFromDate(datePicker.date)
        end = datePicker.date
        changeDate(endDay, date: endDate, time: endTime, datePicked: datePicker.date)
        
        datePickerContainerView.hidden = true

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
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.friendName = fbFriendsListData[indexPath.row].name
        self.friendFID = fbFriendsListData[indexPath.row].id
        self.performSegueWithIdentifier("AddNewEventSegue", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddNewEventSegue" {
            let addEventController = segue.destinationViewController as! AddEventController
            addEventController.friendName = friendName
            addEventController.friendFID = friendFID
            addEventController.startDate = begin
            addEventController.endDate = end
            
            let beginArray = beginAll.componentsSeparatedByString(":")
            let endArray = endAll.componentsSeparatedByString(":")
            
            addEventController.startD = beginDate.text! + ", " + beginArray[2]
            addEventController.startT = beginTime.titleLabel?.text
            addEventController.endD = endDate.text! + ", " + endArray[2]
            addEventController.endT = endTime.titleLabel?.text
        }
    }
}