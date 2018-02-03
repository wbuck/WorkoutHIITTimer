//
//  EmomTimerRepository.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-02-01.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation
import RealmSwift

class EmomTimerRepository: TimerRepository {
    
    private var realm: Realm
    
    init() {
        do { realm = try Realm() }
        catch { fatalError("Error initializing Realm. \(error)") }
    }
    
    func count() -> Int {
        return realm.objects(EmomTimer.self).count
    }
    
    func contains(timer: EmomTimer) -> Bool {
        return realm.objects(EmomTimer.self).contains(timer)
    }
    
    func getAll() -> [EmomTimer] {
        return Array(realm.objects(EmomTimer.self))
    }
    
    func get(timer withId: UUID) -> EmomTimer? {
        return realm.object(ofType: EmomTimer.self, forPrimaryKey: withId.uuidString)
    }
    
    func addOrUpdate(timer: EmomTimer, updateFunc: (() -> Void)? = nil) -> Bool {
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
    
    func delete(timer: EmomTimer) -> Bool {
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
