//
//  RoundTimer.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-14.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation
import RealmSwift

class RoundTimer: TimerBase {
    @objc dynamic var rounds: Int = 1
    @objc private dynamic var roundsTimerDirection: Int = Count.up.rawValue
    var roundsCountDirection: Count {
        get { return Count(rawValue: roundsTimerDirection)! }
        set { roundsTimerDirection = newValue.rawValue }
    }
    @objc dynamic var roundsIntervalInSeconds: TimeInterval = 0
    var timers = LinkingObjects(fromType: Timers.self, property: "roundTimers")
}
