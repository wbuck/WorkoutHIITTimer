//
//  IntervalTimerRepository.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-02-01.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation
import RealmSwift

class IntervalTimerRepository: TimerRepository {
    
    private var realm: Realm
    
    init() {
        do { realm = try Realm() }
        catch { fatalError("Error initializing Realm. \(error)") }
    }
    
    func count() -> Int {
        return realm.objects(IntervalTimer.self).count
    }
    
    func contains(timer: IntervalTimer) -> Bool {
        return realm.objects(IntervalTimer.self).contains(timer)
    }
    
    func getAll() -> [IntervalTimer] {
        return Array(realm.objects(IntervalTimer.self))
    }
    
    func get(timer withId: UUID) -> IntervalTimer? {
        return realm.object(ofType: IntervalTimer.self, forPrimaryKey: withId.uuidString)
    }
    
    func addOrUpdate(timer: IntervalTimer, updateFunc: (() -> Void)? = nil) -> Bool {
        let update = contains(timer: timer)
        do {
            try self.realm.write {
                if let updateFunc = updateFunc { updateFunc() }
                realm.add(timer, update: update)
            }
        } catch {
            print("Failed to save or update the emom timer. \(error)")
            return false
        }
        return true
    }
    
    func delete(timer: IntervalTimer) -> Bool {
        do {
            try realm.write {
                realm.delete(timer)
            }
        }
        catch {
            print("Failed to remove timer. \(error)")
            return false
        }
        return true
    }
}
