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
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pickerControlView: PickerControlView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       // pickerControlView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension RoundTimerViewController: PickerControlViewDelegate {
    
    func pickerControlViewTapped(_ sender: PickerControlView) {
        
        var constraintName = String()
        switch sender.tag {
        case 0:
            constraintName = "HeightConstraint"
        default:
            break;
        }
        
        let heightConstraint = sender.constraints.filter { (constraint) -> Bool in
            return constraint.identifier == constraintName
        }
        let height = Int(sender.frame.height) == sender.collapsedHeight ?
            CGFloat(sender.expandedHeight) : CGFloat(sender.collapsedHeight)
        
        let rotation = Int(sender.frame.height) == sender.collapsedHeight ?
            Rotate.clockwise : Rotate.counterClockwise
        
        heightConstraint.first?.constant =  height
        sender.rotateArrow(in: rotation)
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}





