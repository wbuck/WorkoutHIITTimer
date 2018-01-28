//
//  TimerBase.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-27.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation
import RealmSwift

class TimerBase: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var warmupTimerEnabled: Bool = false
    @objc private dynamic var warmupTimerDirection: Int = Count.up.rawValue
    var warmupCountDirection: Count {
        get { return Count(rawValue: warmupTimerDirection)! }
        set { warmupTimerDirection = newValue.rawValue }
    }
    @objc dynamic var warmupIntervalInSeconds: TimeInterval = 0
    @objc dynamic var restTimerEnabled: Bool = false
    @objc private dynamic var restTimerDirection: Int = Count.up.rawValue
    var restCountDirection: Count {
        get { return Count(rawValue: restTimerDirection)! }
        set { restTimerDirection = newValue.rawValue }
    }
    @objc dynamic var restIntervalInSeconds: TimeInterval = 0
    @objc dynamic var coolDownTimerEnabled: Bool = false
    @objc private dynamic var coolDownTimerDirection: Int = Count.up.rawValue
    var coolDownCountDirection: Count {
        get { return Count(rawValue: coolDownTimerDirection)! }
        set { coolDownTimerDirection = newValue.rawValue }
    }
    @objc dynamic var coolDownIntervalInSeconds: TimeInterval = 0
    @objc dynamic var dateCreated: Date = Date()
    @objc dynamic var startAlertEnabled: Bool = false
    @objc dynamic var startAlertSound: String? = nil
    @objc dynamic var halfwayAlertEnabled: Bool = false
    @objc dynamic var halfwayAlertSound: String? = nil
    @objc dynamic var endAlertEnabled: Bool = false
    @objc dynamic var endAlertSound: String { return "End Beep" }
    @objc dynamic var timerName: String = "Round timer"
    @objc dynamic var timerDescription: String?
    override static func primaryKey() -> String? {
        return "id"
    }
}
