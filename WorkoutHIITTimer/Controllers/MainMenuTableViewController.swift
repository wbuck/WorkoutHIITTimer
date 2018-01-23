//
//  MainMenuTableViewController.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-10.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit
import ChameleonFramework

class MainMenuTableViewController: UITableViewController {
    
    let mainMenuCellId = "MainMenuCell"
    let segueIds = ["GoToMyTimers", "GoToRoundTimer", "GoToEmomTimer", "GoToStopWatch", "GoToTabataTimer", "GoToIntervalTimer"]
    let menuOptions = ["My Timers", "Round Timer", "EMOM Timer", "Stopwatch", "Tabata Timer", "Interval Timer"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register custom table view cell.
        tableView.register(UINib(nibName: "MainMenuTableViewCell", bundle: nil), forCellReuseIdentifier: mainMenuCellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.separatorStyle = .none
        guard let nav = navigationController?.navigationBar else { return }
        nav.tintColor = UIColor(named: "TimerOrange")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("MEMORY WARNING")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    func updateTableContentInset() {
        let numRows = menuOptions.count
        var contentInsetTop = tableView.bounds.size.height
        for i in 0..<numRows {
            contentInsetTop -= tableView(tableView, heightForRowAt: IndexPath(item: i, section: 0))
            if contentInsetTop <= 0 {
                contentInsetTop = 0
            }
        }
        tableView.contentInset = UIEdgeInsetsMake(contentInsetTop, 0, 0, 0)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mainMenuCellId, for: indexPath) as! MainMenuTableViewCell
        // Remove the selection highlight from cell.
        cell.selectionStyle = .none
        if let image = UIImage(named: menuOptions[indexPath.row]) {
            cell.iconImageView.image = image
        }
        if indexPath.row % 2 == 0 {
            cell.iconBackground.backgroundColor = UIColor(named: "TimerBlack")
            cell.labelBackground.backgroundColor = UIColor(named: "TimerGrey")
        }
        else {
            cell.iconBackground.backgroundColor = UIColor(named: "TimerDarkGrey")
            cell.labelBackground.backgroundColor = UIColor(named: "TimerLightGrey")
        }
        
        cell.timerLabel.text = menuOptions[indexPath.row].uppercased()
        return cell
    }
    
    // MARK: - Navigation
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         performSegue(withIdentifier: segueIds[indexPath.row], sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let destination = segue.destination as?
//            TimerSetupTableViewController else { return }
//        if let indexPath = tableView.indexPathForSelectedRow {
//            destination.timerTitle = menuOptions[indexPath.row]
//        }
    }
}











