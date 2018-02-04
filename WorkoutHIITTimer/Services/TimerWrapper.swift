//
//  TimerWrapper.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-02-04.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation
import AsyncTimer

class TimerWrapper {
    private var timer: AsyncTimer!
    private(set) var timerType: TimerType
    private(set) var timerDirection: Count
    let totalTimeInSeconds: TimeInterval
    private(set) var elapsedTimeInSeconds: TimeInterval = 0
    private(set) var isTimerComplete: Bool = false
    private(set) var displayName: String
    private(set) var borderColor: UIColor!
    private(set) var textColor: UIColor!
    var delegate: TimerChangedDelegate?
    var timerState: TimerState {
        get {
            if timer.isRunning { return TimerState.running }
            else if timer.isPaused { return TimerState.paused }
            else { return TimerState.stopped }
        }
    }
    
    init(type: TimerType, name: String, direction: Count, interval: TimeInterval) {
        timerType = type
        displayName = name.uppercased()
        totalTimeInSeconds = interval
        timerDirection = direction
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
        timer = AsyncTimer(queue: .main, interval: .seconds(1), repeats: true, block: {
            if self.elapsedTimeInSeconds == self.totalTimeInSeconds {
                self.timer.stop()
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
    }
    
    func stop() {
        timer.stop()
    }
    
    func pause() {
        timer.pause()
    }
    
    func resume() {
        timer.resume()
    }
    
    func reset() {
        timer.restart()
    }
}
