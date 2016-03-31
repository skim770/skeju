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
    @IBOutlet var endDateLabel: UILabel!
    @IBOutlet var endTimeLabel: UILabel!
    @IBOutlet var availabilitySegCtrl: UISegmentedControl!
    @IBOutlet var scheduleBtn: UIButton!
    
    let userDefault = NSUserDefaults()
    var userFID: String!
    var userName: String!
    var friendFID: String?
    var friendName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 0.4)
        self.navigationController?.navigationBar.tintColor = UIColor.grayColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        self.navigationItem.title = "New Event"
        
        initUI()
        
        userFID = userDefault.valueForKey("FBID") as! String
        userName = userDefault.valueForKey("FBName") as! String
        
        titleLabel.text = "Schedule with \(friendName!)"
    }
    
    @IBAction func scheduleBtnTouchUpInside(sender: AnyObject) {
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
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}