//
//  PickerView.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-19.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit

protocol PickerView {
    var id: Int { get }
    var constraints: [NSLayoutConstraint] { get }
    var pickerViewState: PickerViewState { get }
}
