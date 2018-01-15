//
//  RoundTimerTableViewController.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-13.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit
import RealmSwift

class RoundTimerTableViewController: UITableViewController, UISwitchTableViewHeaderDelegate {
    
    let sectionTitles = ["Timer", "Warm Up", "Rounds", "Rest", "Cool Down", "Warnings"]

    let timerSectionCells = ["Name", "Description"]
    
    /*
    var roundTimer: RoundTimer? {
        didSet {
            
        }
    }
 */
    //let realm = try! Realm()
    let textCellId = "TextFieldTableViewCell"
    let segmentCellId = "SegmentControlTableViewCell"
    let headerWithSwitchId = "HeaderWithSwitch"
    let defaultHeaderId = "DefaultHeader"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "UITextTableViewCell", bundle: nil), forCellReuseIdentifier: textCellId)
        tableView.register(UINib(nibName: "UISegmentTableViewCell", bundle: nil), forCellReuseIdentifier: segmentCellId)
        tableView.register(UINib(nibName: "UISwitchTableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: headerWithSwitchId)
        tableView.register(UINib(nibName: "UITableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: defaultHeaderId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor(named: "TimerFadedGrey")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return timerSectionCells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.section + indexPath.row)
//        switch indexPath.section {
//        case 0:
//            print(0)
//        case 1:
//            print(1)
//        case 2:
//            print(2)
//        case 3:
//            print(3)
//        case 4:
//            print(4)
//        case 5:
//            print(5)
//        default:
//            print("Section doesn't exist")
//        }
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellId, for: indexPath) as! UITextTableViewCell
        ///let cell = dequeueCell(cellId: textCellId, for: indexPath) as UITextTableViewCell
        // Remove the selection highlight from cell.
        cell.selectionStyle = .none
        cell.titleTextLabel.text = timerSectionCells[indexPath.row]
        //cell.inputTextField.placeholder = "Enter \(timerSectionCells[indexPath.row].lowercased())"
        
        let placeHolderColor = UIColor(named: "TimerFadedGrey") ?? UIColor.flatGray
        cell.inputTextField.attributedPlaceholder =
            NSAttributedString(string: "Enter \(timerSectionCells[indexPath.row].lowercased())",
                attributes: [NSAttributedStringKey.foregroundColor : placeHolderColor])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    private func dequeueCell<T>(cellId: String, for indexPath: IndexPath) -> T {
        return tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! T
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
    
    // Enable and disable content in specific cells
    // based on UISwitch value.
    func switchToggled(_ uiSwitch: UISwitch, in section: Int) {
        for row in 0...tableView.numberOfRows(inSection: section) - 1 {
            var cell = tableView.cellForRow(at: NSIndexPath(row: row, section: section) as IndexPath) as! CustomCellActions
            cell.isEnabled = uiSwitch.isOn
        }
    }
}





