//
//  RoundTimerTableViewController.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-13.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit
import RealmSwift

class RoundTimerViewController: UIViewController {
    
    @IBOutlet weak var warmupTimePickerView: TimePickerControlView!
    @IBOutlet weak var warmupSoundPickerView: SoundPickerControlView!
    @IBOutlet weak var roundPickerView: RoundPickerControlView!
    @IBOutlet weak var roundTimerPickerView: TimePickerControlView!
    
    let pickerHeightConstraintNames = ["WarmupTimePickerHeight",
                                       "WarmupSoundPickerHeight",
                                       "RoundPickerHeight",
                                       "RoundTimePickerHeight"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        warmupTimePickerView.delegate = self
        warmupSoundPickerView.delegate = self
        roundPickerView.delegate = self
        roundTimerPickerView.delegate = self
        warmupSoundPickerView.separatorIsHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension RoundTimerViewController: PickerControlViewDelegate {
    
    func pickerControlViewTapped(_ sender: PickerView) {
        
        let constraintName = pickerHeightConstraintNames[sender.id]
        
        // Find constraint with the specified id.
        let heightConstraint = sender.constraints.filter { (constraint) -> Bool in
            return constraint.identifier == constraintName
        }
        
        // Determine next postion (expanded or collapsed).
        let nextPosition: PickerViewState = sender.pickerViewState == .collapsed ?
            .expanded : .collapsed
        
        heightConstraint.first?.constant =  CGFloat(nextPosition.rawValue)
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}





