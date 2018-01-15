//
//  RoundTimer.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-14.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation
import RealmSwift

class RoundTimer: Timer {
    @objc private dynamic var _timerDirection: Int = TimerDirection.up.rawValue
    @objc dynamic var rounds: Int = 0
    @objc dynamic var roundTime: TimeInterval = TimeInterval()
    var timerDirection: TimerDirection {
        get { return TimerDirection(rawValue: _timerDirection)! }
        set { _timerDirection = newValue.rawValue }
    }
}
