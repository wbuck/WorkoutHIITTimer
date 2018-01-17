//
//  PickerControlView.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-15.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit

class PickerControlView: UIView, NibFileOwnerLoadable  {
    
    var time: (Int, Int, Int) = (0, 0, 0) {
        didSet {
            let hour = time.0 < 10 ? "0\(time.0)" : "\(time.0)"
            let minute = time.1 < 10 ? "0\(time.1)" : "\(time.1)"
            let second = time.2 < 10 ? "0\(time.2)" : "\(time.2)"
            timeLabel.text = "\(hour):\(minute):\(second)"
        }
    }
    
    @IBOutlet weak var chevronImage: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var timeLabel: UILabel!

    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibContent()
        pickerView.delegate = self
        pickerView.dataSource = self
        chevronImage.transform = chevronImage.transform.rotated(by: .pi / 2)
    }
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        
    }
    
}

extension PickerControlView: UIPickerViewDataSource, UIPickerViewDelegate {
    
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
            time.0 = row
        case 1:
            time.1 = row
        case 2:
            time.2 = row
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
