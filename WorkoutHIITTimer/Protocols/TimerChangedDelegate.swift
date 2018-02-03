//
//  TimerChangedDelegate.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-02-03.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation

protocol TimerChangedDelegate {
    func timerControl(_ timerControl: TimerControl, elapsedTime inSeconds: TimeInterval, remaining time: TimeInterval)
    func timerControl(_ timerControl: TimerControl, finalTime inSeconds: TimeInterval)
}
