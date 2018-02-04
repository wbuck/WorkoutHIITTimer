//
//  IntegerExtensions.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-02-04.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation

public extension Int {
    
    func formatToHoursMinutesAndSeconds() -> String {
        if self < 0 { return "00:00" }
        let time = (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
        let hour = time.0 < 10 ? "0\(time.0)" : "\(time.0)"
        let minute = time.1 < 10 ? "0\(time.1)" : "\(time.1)"
        let second = time.2 < 10 ? "0\(time.2)" : "\(time.2)"
        return "\(hour):\(minute):\(second)"
    }
    
    func formatToMinutesAndSeconds() -> String {
        if self < 0 { return "00:00" }
        let time = (self / 60, (self % 60))
        let minute = time.0 < 10 ? "0\(time.0)" : "\(time.0)"
        let second = time.1 < 10 ? "0\(time.1)" : "\(time.1)"
        return "\(minute):\(second)"
    }
}
