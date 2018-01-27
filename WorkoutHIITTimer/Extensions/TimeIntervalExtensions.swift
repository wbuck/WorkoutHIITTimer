//
//  TimeIntervalExtensions.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-25.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation


public extension TimeInterval {
    
    func toTuple() -> (hours: UInt, minutes: UInt, seconds: UInt) {
        let seconds = UInt(self)
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    mutating func fromTuple(interval: (hour: UInt, minute: UInt, second: UInt)) {
        let (hour, minute, second) = interval
        self = Double(hour * 3600) + Double(minute * 60) + Double(second)
    }
}
