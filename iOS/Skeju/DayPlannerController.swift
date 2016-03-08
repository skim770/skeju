//
//  DayPlannerController.swift
//  Skeju
//
//  Created by 김성식 on 3/8/16.
//  Copyright © 2016 GeorgiaTech. All rights reserved.
//

import Foundation
import CalendarLib
import EventKit
import EventKitUI

class DayPlannerController: MGCDayPlannerEKViewController {
    override init!(eventStore: EKEventStore!) {
        super.init(eventStore: eventStore)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(eventStore: EKEventStore())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dayPlannerView.delegate = self
    }
}