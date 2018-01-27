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
    @objc dynamic var rounds: Int = 1
    @objc dynamic var roundTimer: SubTimer?
    var timers = LinkingObjects(fromType: Timers.self, property: "roundTimers")
}
