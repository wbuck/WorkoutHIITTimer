//
//  EmomTimer.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-02-01.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation
import RealmSwift

class EmomTimer: Object, WorkoutTimer {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var timerName: String = "Emom timer"
    @objc dynamic var timerDescription: String?
    @objc dynamic var dateCreated: Date = Date()
}
