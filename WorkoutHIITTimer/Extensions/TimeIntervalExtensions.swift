//
//  TimeIntervalExtensions.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-25.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation


public extension TimeInterval {
    
    func toTuple() -> (hours: Int, minutes: Int, seconds: Int) {
        let seconds = Int(self)
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    mutating func fromTuple(interval: (hour: Int, minute: Int, second: Int)) {
        let (hour, minute, second) = interval
        self = Double(hour * 3600) + Double(minute * 60) + Double(second)
    }
}
