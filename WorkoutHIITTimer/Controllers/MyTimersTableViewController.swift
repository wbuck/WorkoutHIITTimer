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

class MyTimersTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    
    let editSegues = ["GoToEditRoundTimer"]
    let timerSegue = "GoToSelectedTimer"
    let headerTitles = ["ROUND TIMERS", "EMOM TIMERS", "STOPWATCHES", "TABATA TIMERS", "INTERVAL TIMERS"]
    var selectedTimerId: String?
    
    var roundTimers = [RoundTimer]()
    var emomTimers = [EmomTimer]()
    var stopWatches = [StopWatch]()
    var tabataTimers = [TabataTimer]()
    var intervalTimers = [IntervalTimer]()
    
    var repositoryFactory: RepositoryFactory!
    
    //var selectedIndex: IndexPath?
    
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
        roundTimers = repositoryFactory.getRoundTimerRepository().getAll()
        emomTimers = repositoryFactory.getEmomTimerRepository().getAll()
        stopWatches = repositoryFactory.getStopWatchRepository().getAll()
        tabataTimers = repositoryFactory.getTabataRepository().getAll()
        intervalTimers = repositoryFactory.getIntervalRepository().getAll()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return headerTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let timerType = TimerType(rawValue: section) else { return 0 }
        switch timerType {
        case .roundTimer:
            return roundTimers.count
        case .emomTimer:
            return emomTimers.count
        case .stopwatch:
            return stopWatches.count
        case .tabataTimer:
            return tabataTimers.count
        case .intervalTimer:
            return intervalTimers.count
        default:
            fatalError("Timer type is not supported here")
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTimerCell", for: indexPath)
            as! MyTimersTableViewCell
        
        cell.delegate = self
        guard let timerType = TimerType(rawValue: indexPath.section) else { return cell }
        switch timerType {
        case .roundTimer:
            cell.timerToDisplay = roundTimers[indexPath.row]
        case .emomTimer:
            cell.timerToDisplay = emomTimers[indexPath.row]
        case .stopwatch:
            cell.timerToDisplay = stopWatches[indexPath.row]
        case .tabataTimer:
            cell.timerToDisplay = tabataTimers[indexPath.row]
        case .intervalTimer:
            cell.timerToDisplay = intervalTimers[indexPath.row]
        default:
            fatalError("Timer type is not supported here")
        }
        cell.setCellBackgroundColor(for: indexPath)
        return cell
    }
    
    private func getTimer(at indexPath: IndexPath) -> WorkoutTimer? {
        guard let timerType = TimerType(rawValue: indexPath.section) else { return nil }
        switch timerType {
        case .roundTimer:
            return roundTimers[indexPath.row]
        case .emomTimer:
            return emomTimers[indexPath.row]
        case .stopwatch:
            return stopWatches[indexPath.row]
        case .tabataTimer:
            return tabataTimers[indexPath.row]
        case .intervalTimer:
            return intervalTimers[indexPath.row]
        default:
            fatalError("Timer type is not supported here")
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") {
            (action, indexPath) in
            guard let timerType = TimerType(rawValue: indexPath.section) else { return }
            switch timerType {
            case .roundTimer:
                let timer = self.roundTimers[indexPath.row]
                _ = self.repositoryFactory.getRoundTimerRepository().delete(timer: timer)
                self.roundTimers.remove(at: indexPath.row)
            case .emomTimer:
                let timer =  self.emomTimers[indexPath.row]
                _ = self.repositoryFactory.getEmomTimerRepository().delete(timer: timer)
                self.emomTimers.remove(at: indexPath.row)
            case .stopwatch:
                let timer = self.stopWatches[indexPath.row]
                _ = self.repositoryFactory.getStopWatchRepository().delete(timer: timer)
                self.stopWatches.remove(at: indexPath.row)
            case .tabataTimer:
                let timer = self.tabataTimers[indexPath.row]
                _ = self.repositoryFactory.getTabataRepository().delete(timer: timer)
                self.tabataTimers.remove(at: indexPath.row)
            case .intervalTimer:
                let timer = self.intervalTimers[indexPath.row]
                _ = self.repositoryFactory.getIntervalRepository().delete(timer: timer)
                self.intervalTimers.remove(at: indexPath.row)
            default:
                fatalError("Timer type is not supported here")
            }
        }
        let editAction = SwipeAction(style: .default, title: "Edit") {
            (action, indexPath) in
            if let timer = self.getTimer(at: indexPath) {
                self.selectedTimerId = timer.id
            }
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
        guard let id = selectedTimerId else { return }
        if let roundTimerController = segue.destination as? RoundTimerViewController {
            roundTimerController.timerRepository = repositoryFactory.getRoundTimerRepository()
            roundTimerController.selectedTimerId = id
        }
            
        else if let roundTimerDisplayController = segue.destination as? RoundTimerDisplayViewController {
            let timer = repositoryFactory.getRoundTimerRepository().get(timer: UUID(uuidString: id)!)
            roundTimerDisplayController.roundTimer = timer
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTimerId = getTimer(at: indexPath)?.id
        performSegue(withIdentifier: timerSegue, sender: self)
    }
}
