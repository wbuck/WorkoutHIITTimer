//
//  TimerDetails.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-14.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation
import RealmSwift

class TimerDetails: Object {
    @objc private dynamic var typeOfTimer: Int = TimerType.stopwatch.rawValue
    @objc dynamic var timerName: String = String()
    @objc dynamic var timerDescription: String? = String()
    var timerType: TimerType {
        get { return TimerType(rawValue: typeOfTimer)! }
        set { typeOfTimer = newValue.rawValue }
    }
    
}
