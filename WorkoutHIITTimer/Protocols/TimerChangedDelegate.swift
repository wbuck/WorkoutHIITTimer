//
//  TimerChangedDelegate.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-02-03.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation

protocol TimerChangedDelegate {
   // func timerStarted(_ timerControl: TimerControl )
   // func timerValueChanged(_ timerControl: TimerControl, elapsedTime inSeconds: TimeInterval, remaining time: TimeInterval)
   // func timerCompleted(_ timerControl: TimerControl, timerCompleted inSeconds: TimeInterval)
    func timerValueChanged(_ timerControl: TimerControl, elapsedTimeInSeconds: TimeInterval, totalTimeInSeconds: TimeInterval)
    func timerComplete(_ timerControl: TimerControl)
}
