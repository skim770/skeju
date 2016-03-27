//
//  FindPeopleController.swift
//  Skeju
//
//  Created by Sung Kim on 3/6/16.
//  Copyright © 2016 GeorgiaTech. All rights reserved.
//

import Foundation
import UIKit

class FindPeopleController: UIViewController {
    
    @IBOutlet var dayPlannerContainer: UIView!
    @IBOutlet var beginTimeView: UIView!
    @IBOutlet var endTimeView: UIView!
    @IBOutlet var foundFriendView: UIView!
    
    var dayPlannerController: DayPlannerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayPlannerController = DayPlannerController(eventStore: EKEventStore())
        dayPlannerController.calendar = NSCalendar.currentCalendar()
        
        self.addChildViewController(dayPlannerController)
        self.dayPlannerContainer.addSubview(dayPlannerController.view)
        dayPlannerController.view.frame = self.dayPlannerContainer.bounds
        dayPlannerController.didMoveToParentViewController(self)
    }
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