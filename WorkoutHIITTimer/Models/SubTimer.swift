//
//  SubTimer.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-15.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation
import RealmSwift

class SubTimer: Object {
    @objc private dynamic var _timerDirection: Int = TimerDirection.up.rawValue
    @objc dynamic var time: TimeInterval = TimeInterval()
        @objc dynamic var sound: String = String()
    var timerDirection: TimerDirection {
        get { return TimerDirection(rawValue: _timerDirection)! }
        set { _timerDirection = newValue.rawValue }
    }
}
