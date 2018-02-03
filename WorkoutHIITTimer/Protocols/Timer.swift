//
//  Timer.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-02-01.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation
import RealmSwift

protocol Timer {
    var id: String { get set }
    var timerName: String  { get set }
    var timerDescription: String? { get set }
    var dateCreated: Date { get set }
}
