//
//  TimerDisplayInformation.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-02-06.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit

class TimerDisplayInformation {
    var timerType: TimerType
    var timerDirection: Count
    var totalTimeInSeconds: TimeInterval
    var displayName: String
    var borderColor: UIColor!
    var textColor: UIColor!
    
    init(type: TimerType, name: String, direction: Count, interval: TimeInterval) {
        timerType = type
        displayName = name.uppercased()
        totalTimeInSeconds = interval
        timerDirection = direction
        selectedColorTheme()
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
}
