//
//  PickerControlView.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-15.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit

@IBDesignable
class TimePickerControlView: ExpandablePickerView, UIPickerViewDataSource, UIPickerViewDelegate  {
    
    
    // Format and display time in label.
    var value: (UInt, UInt, UInt) = (0, 0, 0) {
        didSet {
            if value.0 > 23 || value.1 > 59 || value.2 > 59 { return }
            let hour = value.0 < 10 ? "0\(value.0)" : "\(value.0)"
            let minute = value.1 < 10 ? "0\(value.1)" : "\(value.1)"
            let second = value.2 < 10 ? "0\(value.2)" : "\(value.2)"
            selectedValueLabel.text = "\(hour):\(minute):\(second)"
            pickerView.selectRow(Int(value.0), inComponent: 0, animated: false)
            pickerView.selectRow(Int(value.1), inComponent: 1, animated: false)
            pickerView.selectRow(Int(value.2), inComponent: 2, animated: false)
        }
    }
    
    @IBInspectable
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    private func initialize() {
        pickerView.delegate = self
        pickerView.dataSource = self
        value = (0, 0, 0)
    }
    
    // Define the columns of the picker view.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        // Hours.
        case 0:
            return 24
        // Minutes and seconds.
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
            value.0 = UInt(row)
        case 1:
            value.1 = UInt(row)
        case 2:
            value.2 = UInt(row)
        default:
            break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        label.textColor = UIColor(named: "TimerTextGrey")
        label.font = UIFont.systemFont(ofSize: 17)
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


