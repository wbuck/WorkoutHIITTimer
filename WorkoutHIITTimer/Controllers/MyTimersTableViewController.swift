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
    
    let segueIds = ["GoToEditRoundTimer"]
    let headerTitles = ["ROUND TIMERS", "EMOM TIMERS", "STOPWATCHES", "TABATA TIMERS", "INTERVAL TIMERS"]
    var realm = try! Realm()
    var timers: Timers? {
        didSet { loadTimers() }
    }
    //var workoutTimers = [HeaderSections: [TimerBase]]()
    var workoutTimers = [HeaderSections.roundTimers: [TimerBase](),
             HeaderSections.emomTimers: [TimerBase](),
             HeaderSections.stopWatches: [TimerBase](),
             HeaderSections.tabataTimers: [TimerBase](),
             HeaderSections.intervalTimers: [TimerBase]()]
    var selectedSectionAndIndex: (section: HeaderSections, index: Int)?
    
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
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return workoutTimers.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let section = HeaderSections(rawValue: section) {
            return (workoutTimers[section]?.count)!
        }
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "MyTimerCell", for: indexPath) as! MyTimersTableViewCell
        cell.delegate = self
        cell.selectionStyle = .none
        let section = HeaderSections(rawValue: indexPath.section)!
        let timer = workoutTimers[section]![indexPath.row]
        cell.nameLabel.text = timer.timerName
        cell.descriptionLabel.text = timer.timerDescription
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        cell.dateLabel.text = formatter.string(from: timer.dateCreated)
        cell.cellContentView.backgroundColor = indexPath.row % 2 == 0 ?
            UIColor(named: "TimerGrey") : UIColor(named: "TimerLightGrey")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") {
            (action, indexPath) in
            
            // Get the headers associated key.
            guard let section = HeaderSections(rawValue: indexPath.section) else { return }
//            guard var timers = self.workoutTimers[section] else { return }
//            let timer = timers[indexPath.row]
            
            switch section {
            case HeaderSections.roundTimers:
                guard let timer = self.workoutTimers[section]?[indexPath.row] else { return }
                self.remove(timer: timer as? RoundTimer)
                self.workoutTimers[section]!.remove(at: indexPath.row)
            case HeaderSections.emomTimers:
                print("Emom timer")
            case HeaderSections.stopWatches:
                print("Stopwatches")
            case HeaderSections.tabataTimers:
                print("Tabata")
            case HeaderSections.intervalTimers:
                print("Interval")
            }
        }
        let editAction = SwipeAction(style: .default, title: "Edit") {
            (action, indexPath) in
            self.selectedSectionAndIndex = (HeaderSections(rawValue: indexPath.section)!, indexPath.row)
            self.performSegue(indexPath.section)
        }
        //  editAction.backgroundColor = UIColor(hexString: "FF530D")
        //  deleteAction.image = UIImage(named: "delete-icon")
        editAction.backgroundColor = UIColor(named: "TimerFadedGrey")
        deleteAction.backgroundColor = UIColor(named: "TimerOrange")
        return [deleteAction, editAction]
    }
    
    private func performSegue(_ section: Int){
        self.performSegue(withIdentifier: segueIds[section], sender: self)
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
        guard let segueId = segue.identifier else { return }
        guard let (section, index) = selectedSectionAndIndex else { return }
        
        switch segueId {
        case segueIds[0]:
            if let destination = segue.destination as? RoundTimerViewController {
                destination.roundTimer = workoutTimers[section]?[index] as? RoundTimer
                destination.timers = timers
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    
    private func remove<T: Object>(timer: T?) {
        guard let timerToRemove = timer else { return }
        do {
            try realm.write {
                realm.delete(timerToRemove)
            }
        }
        catch {
            print("Failed to remove todo item. \(error)")
        }
    }
}
