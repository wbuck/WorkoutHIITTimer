//
//  TimersController.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-26.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation

protocol TimersController {
    associatedtype T where T == TimerRepository
    var repository: T!  { get set }
    var selectedTimerPrimaryKey: String? { get set }
}
