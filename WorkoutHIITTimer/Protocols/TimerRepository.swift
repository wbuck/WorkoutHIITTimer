//
//  Repository.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-02-01.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation
import RealmSwift

protocol TimerRepository {
    associatedtype T 
    
    func count() -> Int
    func contains(timer: T) -> Bool
    func getAll() -> [T]
    func get(timer withId: UUID) -> T?
    func addOrUpdate(timer: T, updateFunc: (() -> Void)?) -> Bool
    func delete(timer: T) -> Bool
}
