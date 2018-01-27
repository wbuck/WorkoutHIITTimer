//
//  Timers.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-26.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation
import RealmSwift

class Timers: Object {
    let roundTimers = List<RoundTimer>()
}
