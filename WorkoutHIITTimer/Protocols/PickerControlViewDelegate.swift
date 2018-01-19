//
//  PickerControlViewDelegate.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-16.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import Foundation

protocol PickerControlViewDelegate: NSObjectProtocol  {
    func pickerControlViewTapped(_ sender: TimePickerControlView)
}
