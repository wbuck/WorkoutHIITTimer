//
//  MyTimersTableViewController.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-26.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class MyTimersTableViewController: UITableViewController, TimersController, SwipeTableViewCellDelegate {
    
    let editSegues = ["GoToEditRoundTimer"]
    let timerSegue = "GoToSelectedTimer"
    let headerTitles = ["ROUND TIMERS", "EMOM TIMERS", "STOPWATCHES", "TABATA TIMERS", "INTERVAL TIMERS"]
    var realm = try! Realm()
    var timers: Timers? {
        didSet { loadTimers() }
    }

    var workoutTimers = [HeaderSections.roundTimers: [TimerBase](),
             HeaderSections.emomTimers: [TimerBase](),
             HeaderSections.stopWatches: [TimerBase](),
             HeaderSections.tabataTimers: [TimerBase](),
             HeaderSections.intervalTimers: [TimerBase]()]

    var selectedIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.rowHeight = 86
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        loadTimers()
        tableView.reloadData()
    }
    
    private func loadTimers() {
        guard let allTimers = timers else { return }
        let roundTimers: [TimerBase] = allTimers.roundTimers.map{ $0 as TimerBase }
        workoutTimers[.roundTimers]?.removeAll()
        workoutTimers[.roundTimers]?.append(contentsOf: roundTimers)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return workoutTimers.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let section = HeaderSections(rawValue: section) {
            return workoutTimers[section]?.count ?? 0
        }
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTimerCell", for: indexPath)
            as! MyTimersTableViewCell
        
        cell.delegate = self
        if let section = HeaderSections(rawValue: indexPath.section) {
            if let timer = workoutTimers[section]?[indexPath.row] {
                cell.timerToDisplay = timer
            }
        }
        cell.setCellBackgroundColor(for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") {
            (action, indexPath) in
            self.removeTimer(at: indexPath)
        }
        let editAction = SwipeAction(style: .default, title: "Edit") {
            (action, indexPath) in
            self.selectedIndex = indexPath
            self.performSegue(indexPath.section)
        }
        editAction.image = UIImage(named: "Gears")
        deleteAction.image = UIImage(named: "Trash Can")
        editAction.backgroundColor = UIColor(named: "TimerFadedGrey")
        deleteAction.backgroundColor = UIColor(named: "TimerOrange")
        return [deleteAction, editAction]
    }
    
    private func performSegue(_ section: Int){
        self.performSegue(withIdentifier: editSegues[section], sender: self)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderView()
        header.title = headerTitles[section]
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = selectedIndex else { return }
        if var timerController = segue.destination as? TimersController {
            timerController.timers = timers
            timerController.selectedIndex = indexPath
        }
        else if let timer = segue.destination as? TimerViewController {
            timer.timers = timers
            timer.selectedIndex = selectedIndex
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        performSegue(withIdentifier: timerSegue, sender: self)
    }
    
    private func removeTimer(at indexPath: IndexPath) {
        guard let section = HeaderSections(rawValue: indexPath.section) else { return }
        guard workoutTimers.keys.contains(section) else { return }
        let timer = workoutTimers[section]![indexPath.row]
        do {
            try realm.write {
                realm.delete(timer)
                workoutTimers[section]!.remove(at: indexPath.row)
            }
        }
        catch {
            print("Failed to remove timer. \(error)")
        }
    }
}
