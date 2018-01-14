//
//  TableViewHeaderSwitchToggled.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-14.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit

protocol UISwitchTableViewHeaderDelegate: class {
    func switchToggled( _ uiSwitch: UISwitch, in section: Int)
}
