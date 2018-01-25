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
    @objc private dynamic var countDirection: Int = Count.up.rawValue
    @objc dynamic var intervalInSeconds: Int = 0
    var timerDirection: Count {
        get { return Count(rawValue: countDirection)! }
        set { countDirection = newValue.rawValue }
    }
}
