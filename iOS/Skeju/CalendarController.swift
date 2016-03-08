//
//  CalendarController.swift
//  Skeju
//
//  Created by Sung Kim on 3/6/16.
//  Copyright © 2016 GeorgiaTech. All rights reserved.
//

import Foundation
import UIKit
import JTCalendar
import EventKit
import EventKitUI

class CalendarController: UIViewController, JTCalendarDelegate {
    @IBOutlet var calendarMenuView: JTCalendarMenuView!
    @IBOutlet var calendarContentView: JTHorizontalCalendarView!
    @IBOutlet var statusBarView: UIView!
    
    var calendarManager: JTCalendarManager!
    var _dateSelected: NSDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarManager = JTCalendarManager()
        calendarManager.delegate = self
        initUI()
        
        calendarManager.menuView = calendarMenuView
        calendarManager.contentView = calendarContentView
        calendarManager.setDate(NSDate())
        
//        calendarManager.menuView.label
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        calendarManager.reload()
    }
    
    func calendar(calendar: JTCalendarManager!, prepareDayView day: UIView!) {
        if let dayView = day as? JTCalendarDayView {
            dayView.hidden = false
            dayView.textLabel.font = UIFont.boldSystemFontOfSize(15)
            if dayView.isFromAnotherMonth {
                dayView.textLabel.textColor = UIColor.lightGrayColor()
                dayView.textLabel.font = UIFont.systemFontOfSize(12)
                dayView.textLabel.alpha = 0.5
            } else if calendarManager.dateHelper.date(NSDate(), isTheSameDayThan: dayView.date) {
                dayView.circleView.hidden = false
                dayView.circleView.backgroundColor = UIColor(red: 96/255.0, green: 170/255.0, blue: 1, alpha: 1)
                dayView.dotView.backgroundColor = UIColor.whiteColor()
                dayView.textLabel.textColor = UIColor.whiteColor()
            } else if _dateSelected != nil && calendarManager.dateHelper.date(_dateSelected, isTheSameDayThan: dayView.date) {
                dayView.circleView.hidden = false
                dayView.circleView.backgroundColor = UIColor(red: 187/255.0, green: 88/255.0, blue: 88/255.0, alpha: 1)
                dayView.dotView.backgroundColor = UIColor.whiteColor()
                dayView.textLabel.textColor = UIColor.whiteColor()
            } else {
                dayView.circleView.hidden = true
                dayView.dotView.backgroundColor = UIColor.redColor()
                dayView.textLabel.textColor = UIColor.blackColor()
            }
            
//            if self.haveEventForDay(dayView.date) {
//                dayView.dotView.hidden = false
//            } else {
//                dayView.dotView.hidden = true
//            }
        }
    }
    
    func calendar(calendar: JTCalendarManager!, didTouchDayView day: UIView!) {
        if let dayView = day as? JTCalendarDayView {
            _dateSelected = dayView.date
            
            dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1)
            UIView.transitionWithView(dayView, duration: 0.3, options: UIViewAnimationOptions.AllowAnimatedContent, animations: {
                    dayView.circleView.transform = CGAffineTransformIdentity
                    self.calendarManager.reload()
                }, completion: nil)
            
            if !calendarManager.dateHelper.date(calendarContentView.date, isTheSameMonthThan: dayView.date) {
                if self.calendarContentView.date.compare(dayView.date) == NSComparisonResult.OrderedAscending {
                    self.calendarContentView.loadNextPageWithAnimation()
                } else {
                    self.calendarContentView.loadPreviousPageWithAnimation()
                }
            }
        }
    }
    
    func initUI() {
        statusBarView.clipsToBounds = false
        statusBarView.layer.masksToBounds = false
        statusBarView.layer.shadowColor = UIColor.darkGrayColor().CGColor
        statusBarView.layer.shadowRadius = 5
        statusBarView.layer.shadowOffset = CGSizeMake(0, 5)
        statusBarView.layer.shadowOpacity = 0.75
        
        calendarMenuView.clipsToBounds = false
        calendarMenuView.layer.masksToBounds = false
        calendarMenuView.layer.shadowColor = UIColor.darkGrayColor().CGColor
        calendarMenuView.layer.shadowRadius = 5
        calendarMenuView.layer.shadowOffset = CGSizeMake(0, 5)
        calendarMenuView.layer.shadowOpacity = 0.75
        
        calendarContentView.clipsToBounds = false
        calendarContentView.layer.masksToBounds = false
        calendarContentView.layer.shadowColor = UIColor.darkGrayColor().CGColor
        calendarContentView.layer.shadowRadius = 5
        calendarContentView.layer.shadowOffset = CGSizeMake(0, 5)
        calendarContentView.layer.shadowOpacity = 0.75
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}