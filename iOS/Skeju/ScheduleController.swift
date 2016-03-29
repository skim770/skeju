//
//  ScheduleController.swift
//  Skeju
//
//  Created by Sung Kim on 3/6/16.
//  Copyright © 2016 GeorgiaTech. All rights reserved.
//

import Foundation
import UIKit
import EventKit
import FBSDKCoreKit

class ScheduleController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    @IBOutlet var container: UIView!
    @IBOutlet var friendContainer: UIView!
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var userProfilePic: UIImageView!
    @IBOutlet var friendProfilePic: UIImageView!
    @IBOutlet var friendName: UILabel!
    @IBOutlet var addFriendBtn: UIButton!
    @IBOutlet var fbFriendsList: UITableView!
    @IBOutlet var scrollMask: UIScrollView!
    
    let userDefault = NSUserDefaults()
    let screenWidth = UIScreen.mainScreen().bounds.width
    var schedule: DayPlannerController!
    var friendSchedule: DayPlannerController!
    var fbFriendsListData = [(name: String, id: String, profile: UIImage)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        schedule = DayPlannerController(eventStore: EKEventStore())
        schedule.calendar = NSCalendar.currentCalendar()
        schedule.view.frame = container.bounds
        container.addSubview(schedule.view)
        container.hidden = true
        container.layer.masksToBounds = true
        
        friendSchedule = DayPlannerController(eventStore: EKEventStore())
        friendSchedule.calendar = NSCalendar.currentCalendar()
        friendSchedule.view.frame = friendContainer.bounds
        friendSchedule.dayPlannerView.timeColumnWidth = 0
        friendContainer.addSubview(friendSchedule.view)
        friendContainer.hidden = true
        
        fbFriendsList.delegate = self
        fbFriendsList.dataSource = self

        let plannerContentHeight = schedule.dayPlannerView.dayColumnSize.height
        scrollMask.delegate = self
        scrollMask.contentSize = CGSizeMake(screenWidth, plannerContentHeight)
        scrollMask.hidden = true
        
        let dateComponents = NSCalendar.currentCalendar().components([.Day, .Month, .Year], fromDate: NSDate())
        let df = NSDateFormatter()
        monthLabel.text = df.monthSymbols[dateComponents.month - 1]
        dayLabel.text = String(dateComponents.day)
        userProfilePic.layer.cornerRadius = 29
        
        if FBSDKAccessToken.currentAccessToken() != nil {
            let fbGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
            fbGraphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error) != nil {
                    print("Error: \(error)")
                } else {
                    self.userDefault.setValue(result.valueForKey("name"), forKey: "FBName")
                    self.userDefault.setValue(result.valueForKey("id"), forKey: "FBID")
                    
                    let fbPicURL = "https://graph.facebook.com/\(self.userDefault.valueForKey("FBID") as! String)/picture?type=normal&return_ssl_resources=1"
                    let fbRequest = NSURL(string: fbPicURL)
                    let fbProfilePicData = NSData(contentsOfURL: fbRequest!)
                    let fbProfilePic = UIImage(data: fbProfilePicData!)
                    self.userProfilePic.image = fbProfilePic
                }
            })
        }
        
        let fbGraphRequest = FBSDKGraphRequest(graphPath: "me/friends", parameters: nil, HTTPMethod: "GET")
        fbGraphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            if error != nil {
                print("Error: \(error)")
            } else {
                let friendsDict = result as! NSDictionary
                let data : NSArray = friendsDict.objectForKey("data") as! NSArray
                
                for i in 0..<data.count {
                    let valueDict : NSDictionary = data[i] as! NSDictionary
                    let fname = valueDict.objectForKey("name") as! String
                    let fid = valueDict.objectForKey("id") as! String
                    
                    let fbPicURL = "https://graph.facebook.com/\(fid)/picture?type=normal&return_ssl_resources=1"
                    let fbRequest = NSURL(string: fbPicURL)
                    let fbProfilePicData = NSData(contentsOfURL: fbRequest!)
                    let fbProfilePic = UIImage(data: fbProfilePicData!)
                    
                    self.fbFriendsListData.append((name: fname, id: fid, profile: fbProfilePic!))
                }
                
                self.fbFriendsList.reloadData()
            }
        })
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = fbFriendsList.dequeueReusableCellWithIdentifier("FBFriendCell")! as UITableViewCell
        cell.textLabel?.text = fbFriendsListData[indexPath.row].name
        cell.imageView?.image = fbFriendsListData[indexPath.row].profile
        cell.imageView?.layer.cornerRadius = 5
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.friendName.text = fbFriendsListData[indexPath.row].name
        self.friendProfilePic.image = fbFriendsListData[indexPath.row].profile
        self.friendProfilePic.contentMode = UIViewContentMode.ScaleToFill
        self.friendProfilePic.layer.cornerRadius = 29
        showSchedules()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fbFriendsListData.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(50)
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Friends from Facebook"
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.isEqual(scrollMask) {
            schedule.dayPlannerView.sTimeScrollView.contentOffset = scrollView.contentOffset
            schedule.dayPlannerView.sTimedEventsView.contentOffset = scrollView.contentOffset
            friendSchedule.dayPlannerView.sTimeScrollView.contentOffset = scrollView.contentOffset
            friendSchedule.dayPlannerView.sTimedEventsView.contentOffset = scrollView.contentOffset
        }
    }
    
    @IBAction func addFriendBtnTouchUpInside(sender: AnyObject) {
        print("Add Friend Button Pressed")
        showFBFriendsList()
    }
    
    func showFBFriendsList() {
        self.container.hidden = true
        self.friendContainer.hidden = true
        self.scrollMask.hidden = true
        self.fbFriendsList.hidden = false
    }
    
    func showSchedules() {
        self.fbFriendsList.hidden = true
        self.container.hidden = false
        self.friendContainer.hidden = false
        self.scrollMask.hidden = false
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}