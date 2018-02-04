//
//  TimerChangedDelegate.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-02-03.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation

protocol TimerChangedDelegate {
    func timerStarted(_ timerControl: TimerWrapper )
    func timerValueChanged(_ timerControl: TimerWrapper, elapsedTimeInSeconds: TimeInterval, totalTimeInSeconds: TimeInterval)
    func timerComplete(_ timerControl: TimerWrapper)
}
