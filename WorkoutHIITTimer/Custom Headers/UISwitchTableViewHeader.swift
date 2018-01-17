//
//  UISwitchTableViewHeader.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-14.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit

class UISwitchTableViewHeader: UITableViewHeaderFooterView {    
    
    var section: Int!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var uiSwitch: UISwitch!
    
    @IBAction func uiSwitchValueChanged(_ sender: UISwitch) {
        
    }
    
}
