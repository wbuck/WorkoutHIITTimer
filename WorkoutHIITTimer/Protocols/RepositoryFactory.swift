//
//  RepositoryFactory.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-02-01.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation

protocol RepositoryFactory {
    func getRoundTimerRepository() -> RoundTimerRepository
    func getEmomTimerRepository() -> EmomTimerRepository
    func getStopWatchRepository() -> StopWatchRepository
    func getTabataRepository() -> TabataTimerRepository
    func getIntervalRepository() -> IntervalTimerRepository
}
