//
//  TimerWrapper.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-02-04.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation
import SwiftyTimer

class TimerWrapper {
    private var timer: Timer!
    private(set) var timerType: TimerType
    private(set) var timerDirection: Count
    let totalTimeInSeconds: TimeInterval
    private(set) var elapsedTimeInSeconds: TimeInterval = 0
    private(set) var isTimerComplete: Bool = false
    private(set) var displayName: String
    private(set) var borderColor: UIColor!
    private(set) var textColor: UIColor!
    var delegate: TimerChangedDelegate?
    private(set) var timerState: TimerState
    
    init(type: TimerType, name: String, direction: Count, interval: TimeInterval) {
        timerType = type
        displayName = name.uppercased()
        totalTimeInSeconds = interval
        timerDirection = direction
        timerState = .stopped
        selectedColorTheme()
        createTimer()
    }
    
    private func selectedColorTheme() {
        switch timerType {
        case .warmupTimer:
            borderColor = UIColor(named: "TimerYellow") ?? UIColor.yellow
        case .restTimer:
            borderColor = UIColor(named: "TimerGreen") ?? UIColor.green
        case .coolDownTimer:
            borderColor = UIColor(named: "TimerBlue") ?? UIColor.blue
        default:
            borderColor = UIColor(named: "TimerOrange") ?? UIColor.orange
        }
        textColor = UIColor(named: "TimerWhite") ?? UIColor.white
    }
    
    private func createTimer() {
        timer = Timer.new(every: 1.seconds, { (timer) in
            if !timer.isValid { return }
            let formatter = DateFormatter()
            formatter.dateFormat = "ss.SSSS"
            print("\(formatter.string(from: Date())) Current elapsed time \(self.elapsedTimeInSeconds)")
            if self.elapsedTimeInSeconds == self.totalTimeInSeconds {
                timer.invalidate()
                self.isTimerComplete = true
                self.delegate?.timerComplete(self)
            } else {
                if self.elapsedTimeInSeconds == 0 {
                    self.delegate?.timerStarted(self)
                }
                self.elapsedTimeInSeconds += 1
                self.delegate?.timerValueChanged(self, elapsedTimeInSeconds: self.elapsedTimeInSeconds, totalTimeInSeconds: self.totalTimeInSeconds)
            }
        })
    }
    
    func start() {
        timer.start()
        timerState = .running
    }
    
    func stop() {
        timer.invalidate()
        timerState = .stopped
    }
    
    func pause() {
        timer.invalidate()
        timerState = .paused
    }
    
    func resume() {
        createTimer()
        start()
    }
    
    func reset() {
        elapsedTimeInSeconds = 0
        createTimer()
        timerState = .stopped
    }
}
