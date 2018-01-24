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
    let pickerHeightConstraintNames = [1 : "WarmupTimePickerHeight",
                                       2 : "RoundPickerHeight",
                                       3 : "RoundTimePickerHeight",
                                       4 : "RestTimePickerHeight",
                                       5 : "CoolDownTimePickerHeight",
                                       6 : "AlertStartingSoundPickerHeight",
                                       7 : "AlertHalfwaySoundPickerHeight"]
    
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
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("ROUND MEMORY WARNING")
    }
    
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        let controls = contentView.subviews.filter { (control) -> Bool in
            return control is TextFieldView
        }
        if let textView = controls.first as? TextFieldView {
            print(textView.value!)
        }
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







