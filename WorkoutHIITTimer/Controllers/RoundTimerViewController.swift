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
    
    @IBOutlet weak var contentView: UIView!
    
    // The key represents the tag of each picker
    // view control. The value is the name of
    // the height constraint.
    let pickerHeightConstraintNames = [2 : "WarmupTimePickerHeight",
                                       4 : "WarmupSoundPickerHeight",
                                       5 : "RoundPickerHeight",
                                       6 : "RoundTimePickerHeight",
                                       8 : "RoundSoundPickerHeight",
                                       9 : "RestTimePickerHeight",
                                       11 : "RestSoundPickerHeight",
                                       12 : "CoolDownTimePickerHeight",
                                       14 : "CoolDownSoundPickerHeight"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Find all of the subviews which are ExpandablePickerViews.
        contentView.subviews.filter({ (control) -> Bool in
            return control.self is ExpandablePickerView
        }).forEach { (control) in
            let picker = control as! ExpandablePickerView
            // Set delegate and hide separator on specfic
            // picker views.
            picker.delegate = self
            picker.separatorIsHidden = (picker.id == 4 || picker.id == 8 || picker.id == 11 || picker.id == 14)
        }
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





