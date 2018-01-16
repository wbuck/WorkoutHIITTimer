//
//  PickerControlExpansionView.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-16.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit

class PickerControlExpansionView: UIView, NibFileOwnerLoadable, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var pickerView: UIPickerView!
    var hours = 0
    var minutes = 0
    var seconds = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibContent()
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }
    
    
    // MARKL - UIPickerView data source methods.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 24
        case 1,2:
            return 60
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.width / 3
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            hours = row
        case 1:
            minutes = row
        case 2:
            seconds = row
        default:
            break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        label.textColor = UIColor(named: "TimerTextGrey")
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        switch component {
        case 0:
            label.text = "\(row) hours"
        case 1:
            label.text = "\(row) min"
        case 2:
            label.text = "\(row) sec"
        default:
            label.text = String()
        }
        return label
    }
}
