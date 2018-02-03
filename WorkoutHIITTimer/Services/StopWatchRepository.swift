//
//  StopWatchRepository.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-02-01.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation
import RealmSwift

class StopWatchRepository: TimerRepository {
    
    private var realm: Realm
    
    init() {
        do { realm = try Realm() }
        catch { fatalError("Error initializing Realm. \(error)") }
    }
    
    func count() -> Int {
        return realm.objects(StopWatch.self).count
    }
    
    func contains(timer: StopWatch) -> Bool {
        return realm.objects(StopWatch.self).contains(timer)
    }
    
    func getAll() -> [StopWatch] {
        return Array(realm.objects(StopWatch.self))
    }
    
    func get(timer withId: UUID) -> StopWatch? {
        return realm.object(ofType: StopWatch.self, forPrimaryKey: withId.uuidString)
    }
    
    func addOrUpdate(timer: StopWatch, updateFunc: (() -> Void)? = nil) -> Bool {
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
    
    func delete(timer: StopWatch) -> Bool {
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
