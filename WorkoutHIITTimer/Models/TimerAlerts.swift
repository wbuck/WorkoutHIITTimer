//
//  WarningDetails.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-14.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation
import RealmSwift

class TimerAlerts: Object {
    @objc dynamic var startAlertEnabled: Bool = false
    @objc dynamic var startAlertSound: String?
    @objc dynamic var halfwayAlertEnabled: Bool = false
    @objc dynamic var halfwayAlertSound: String?
    @objc dynamic var endAlertEnabled: Bool = false
    @objc dynamic var endAlertSound: String?
}
