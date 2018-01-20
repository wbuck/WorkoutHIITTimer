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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        warmupTimePickerView.delegate = self
        warmupSoundPickerView.delegate = self
        warmupSoundPickerView.separatorIsHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension RoundTimerViewController: PickerControlViewDelegate {
    
    func pickerControlViewTapped(_ sender: PickerView) {
        
        var constraintName = String()
        switch sender.id {
        case 0:
            constraintName = "WarmupTimePickerHeight"
        case 1:
            constraintName = "WarmupSoundPickerHeight"
        default:
            break;
        }
        
        // Find constraint with the specified id.
        let heightConstraint = sender.constraints.filter { (constraint) -> Bool in
            return constraint.identifier == constraintName
        }
        
        // Determine next postion.
        let nextPosition: PickerViewState = sender.pickerViewState == .collapsed ?
            .expanded : .collapsed
        
        heightConstraint.first?.constant =  CGFloat(nextPosition.rawValue)
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}





