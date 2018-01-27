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
    
    let roundTimerSegue = "GoToEditRoundTimer"
    var realm = try! Realm()
    var timers: Timers? {
        didSet { loadTimers() }
    }
    
    var roundTimers: List<RoundTimer>?
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.rowHeight = 86
    }
    
    private func loadTimers() {
        guard let allTimers = timers else { return }
        roundTimers = allTimers.roundTimers
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return roundTimers?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTimerCell", for: indexPath)
            as! MyTimersTableViewCell
        cell.delegate = self
        // Remove the selection highlight from cell.
        cell.selectionStyle = .none
        var timer: Timer?
        
        switch indexPath.section {
        case HeaderSections.roundTimers.rawValue:
            timer = roundTimers?[indexPath.row]
        case HeaderSections.emomTimers.rawValue:
            print("Emom timer")
        case HeaderSections.stopWatches.rawValue:
            print("Stopwatches")
        case HeaderSections.tabataTimers.rawValue:
            print("Tabata")
        case HeaderSections.intervalTimers.rawValue:
            print("Interval")
        default:
            break
        }
        
        if timer != nil {
            cell.nameLabel.text = timer!.timerDetails?.timerName
            cell.descriptionLabel.text = timer!.timerDetails?.timerDescription
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            cell.dateLabel.text = formatter.string(from: timer!.dateCreated)
            print(indexPath.row)
            cell.cellContentView.backgroundColor = indexPath.row % 2 == 0 ?
                UIColor(named: "TimerGrey") : UIColor(named: "TimerLightGrey")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") {
            (action, indexPath) in
            
            switch indexPath.section {
            case HeaderSections.roundTimers.rawValue:
                if let timer = self.roundTimers?[indexPath.row] {
                    self.remove(timer: timer)
                }
            case HeaderSections.emomTimers.rawValue:
                print("Emom timer")
            case HeaderSections.stopWatches.rawValue:
                print("Stopwatches")
            case HeaderSections.tabataTimers.rawValue:
                print("Tabata")
            case HeaderSections.intervalTimers.rawValue:
                print("Interval")
            default:
                break
            }
        }
        let editAction = SwipeAction(style: .default, title: "Edit") {
            (action, indexPath) in
            switch indexPath.section {
            case HeaderSections.roundTimers.rawValue:
                self.selectedIndex = indexPath.row
                self.performSegue(withIdentifier: self.roundTimerSegue, sender: self)
            case HeaderSections.emomTimers.rawValue:
                print("Emom timer")
            case HeaderSections.stopWatches.rawValue:
                print("Stopwatches")
            case HeaderSections.tabataTimers.rawValue:
                print("Tabata")
            case HeaderSections.intervalTimers.rawValue:
                print("Interval")
            default:
                break
            }
        }
        //        editAction.backgroundColor = UIColor(hexString: "FF530D")
        //        deleteAction.image = UIImage(named: "delete-icon")
        editAction.backgroundColor = UIColor(named: "TimerFadedGrey")
        deleteAction.backgroundColor = UIColor(named: "TimerOrange")
        return [deleteAction, editAction]
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderView()
        switch section {
        case HeaderSections.roundTimers.rawValue:
            header.title = "ROUND TIMERS"
        case HeaderSections.emomTimers.rawValue:
            header.title = "EMOM TIMERS"
        case HeaderSections.stopWatches.rawValue:
            header.title = "STOPWATCHES"
        case HeaderSections.tabataTimers.rawValue:
            header.title = "TABATA TIMERS"
        case HeaderSections.intervalTimers.rawValue:
            header.title = "INTERVAL TIMERS"
        default:
            break
        }
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueId = segue.identifier else { return }
        switch segueId {
        case roundTimerSegue:
            if let destination = segue.destination as? RoundTimerViewController {
                destination.roundTimer = roundTimers?[selectedIndex!]
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
    
    private func remove<T: Object>(timer: T) {
        do { try realm.write { realm.delete(timer) } }
        catch { print("Failed to remove todo item. \(error)") }
    }
}
