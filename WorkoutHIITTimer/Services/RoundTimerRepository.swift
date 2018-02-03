//
//  RoundTimerRepository.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-02-01.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation
import RealmSwift

class RoundTimerRepository: TimerRepository {
    
    private var realm: Realm
    
    init() {
        do { realm = try Realm() }
        catch { fatalError("Error initializing Realm. \(error)") }
    }
    
    func count() -> Int {
        return realm.objects(RoundTimer.self).count
    }
    
    func contains(timer: RoundTimer) -> Bool {
        return realm.objects(RoundTimer.self).contains(timer)
    }
    
    func getAll() -> [RoundTimer] {
        return Array(realm.objects(RoundTimer.self))
    }
    
    func get(timer withId: UUID) -> RoundTimer? {
        return realm.object(ofType: RoundTimer.self, forPrimaryKey: withId.uuidString)
    }
    
    func addOrUpdate(timer: RoundTimer, updateFunc: (() -> Void)? = nil) -> Bool {
        let update = contains(timer: timer)
        do {
            try self.realm.write {
                if let updateFunc = updateFunc { updateFunc() }
                realm.add(timer, update: update)
            }
        } catch {
            print("Failed to save or update the round timer. \(error)")
            return false
        }
        return true
    }
    
    func delete(timer: RoundTimer) -> Bool {
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
