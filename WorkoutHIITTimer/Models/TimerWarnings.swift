//
//  WarningDetails.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-14.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation
import RealmSwift

class TimerWarnings: Object {
    @objc dynamic var halfwayWarning: Bool = false
    @objc dynamic var halfwaySound: String = String()
    @objc dynamic var endWarning: Bool = false
    @objc dynamic var timeEndWarningStarts: TimeInterval = 10
    @objc dynamic var endSound: String = String()
}
