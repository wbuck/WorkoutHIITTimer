//
//  RoundTimerTableViewController.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-13.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit

class RoundTimerTableViewController: UITableViewController, UISwitchTableViewHeaderDelegate {

    let sectionTitles = ["Timer", "Warm Up", "Rounds", "Rest", "Cool Down", "Warnings"]
    let test = ["Name", "Description"]
    let textCellId = "TextCell"
    let headerWithSwitchId = "HeaderWithSwitch"
    let defaultHeaderId = "DefaultHeader"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TextTableViewCell", bundle: nil), forCellReuseIdentifier: textCellId)
        tableView.register(UINib(nibName: "UISwitchTableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: headerWithSwitchId)
        tableView.register(UINib(nibName: "UITableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: defaultHeaderId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor(named: "TimerFadedGrey")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return test.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellId, for: indexPath) as! TextTableViewCell
        cell.titleTextLabel.text = test[indexPath.row]
        cell.inputTextField.placeholder = "Enter \(test[indexPath.row].lowercased())"
        
        let placeHolderColor = UIColor(named: "TimerFadedGrey") ?? UIColor.flatGray
        cell.inputTextField.attributedPlaceholder =
            NSAttributedString(string: "Enter \(test[indexPath.row].lowercased())",
                attributes: [NSAttributedStringKey.foregroundColor : placeHolderColor])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 || section == 2 || section == 5 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: defaultHeaderId)
                as! UITableViewHeader
            
            header.headerTitle.text = sectionTitles[section].uppercased()
            header.section = section
            return header
        }
        else {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerWithSwitchId)
                as! UISwitchTableViewHeader
            
            header.headerTitle.text = sectionTitles[section].uppercased()
            header.section = section
            header.delegate = self
            return header
        }
    }
    
    // MARK: - UISwitchTableViewHeaderDelegate delegate methods
    
    func switchToggled(_ uiSwitch: UISwitch, in section: Int) {
        
    }
}





