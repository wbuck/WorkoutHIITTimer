//
//  MainMenuTableViewController.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-10.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit
import RealmSwift

class MainMenuTableViewController: UITableViewController {
    
    var realm = try! Realm()
    var repositoryFactory: RepositoryFactory!
    
    let mainMenuCellId = "MainMenuCell"
    let segueIds = ["GoToMyTimers", "GoToRoundTimer", "GoToEmomTimer",
                    "GoToStopWatch", "GoToTabataTimer", "GoToIntervalTimer"]
    
    let menuOptions = ["My Timers", "Round Timer", "EMOM Timer",
                       "Stopwatch", "Tabata Timer", "Interval Timer"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register custom table view cell.
        tableView.register(UINib(nibName: "MainMenuTableViewCell", bundle: nil),
                           forCellReuseIdentifier: mainMenuCellId)
        repositoryFactory = TimerRepositoryFactory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.separatorStyle = .none
        guard let nav = navigationController?.navigationBar else { return }
        nav.tintColor = UIColor(named: "TimerOrange")
        navigationController?.isNavigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("MEMORY WARNING")
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
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
        if let roundTimerViewController = segue.destination as? RoundTimerViewController {
            roundTimerViewController.timerRepository = repositoryFactory.getRoundTimerRepository()
        }
        else if let myTimersViewController = segue.destination as? MyTimersTableViewController {
            myTimersViewController.repositoryFactory = repositoryFactory
        }
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) { /* Intentionally left empty */}
}











