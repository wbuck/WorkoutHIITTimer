//
//  RepositoryFactory.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-02-01.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation

class TimerRepositoryFactory: RepositoryFactory {
    func getRoundTimerRepository() -> RoundTimerRepository {
        return RoundTimerRepository()
    }
    
    func getEmomTimerRepository() -> EmomTimerRepository {
        return EmomTimerRepository()
    }
    
    func getStopWatchRepository() -> StopWatchRepository {
        return StopWatchRepository()
    }
    
    func getTabataRepository() -> TabataTimerRepository {
        return TabataTimerRepository()
    }
    
    func getIntervalRepository() -> IntervalTimerRepository {
        return IntervalTimerRepository()
    }
    
    
}
