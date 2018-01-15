//
//  Timer.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-14.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation
import RealmSwift

class Timer: Object {
    @objc dynamic var timerInfo: TimerInfo = TimerInfo()
    @objc dynamic var warmupTimer: SubTimer = SubTimer()
    @objc dynamic var cooldownTimer: SubTimer = SubTimer()
    @objc dynamic var timerWarnings: TimerWarnings = TimerWarnings()
}
