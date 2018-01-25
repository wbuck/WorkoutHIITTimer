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
    @objc dynamic var timerInfo: TimerDetails?
    @objc dynamic var warmupTimerEnabled: Bool = false
    @objc dynamic var warmupTimer: SubTimer?
    @objc dynamic var restTimerEnabled: Bool = false
    @objc dynamic var restTimer: SubTimer?
    @objc dynamic var coolDownTimerEnabled: Bool = false
    @objc dynamic var cooldownTimer: SubTimer?
    @objc dynamic var timerAlerts: TimerAlerts?
    @objc dynamic var dateCreated: Date = Date()
}
