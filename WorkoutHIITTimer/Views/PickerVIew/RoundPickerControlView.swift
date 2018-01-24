//
//  RoundPickerControlView.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-20.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit

@IBDesignable
class RoundPickerControlView: ExpandablePickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var rounds = [Int](1...100)
    
    @IBInspectable
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    @IBInspectable
    var isEnabled: Bool = true {
        didSet {
            titleLabel.isEnabled = isEnabled
            selectedValueLabel.isEnabled = isEnabled
            pickerView.isUserInteractionEnabled = isEnabled
        }
    }
    
    @IBInspectable
    var section: String = String()
    
    var value: Int {
        get {
            return rounds[pickerView.selectedRow(inComponent: 0)]
        }
        set {
            if newValue < 1 || newValue > 100 { return }
            selectedValueLabel.text = String(newValue)
            pickerView.selectRow(newValue - 1, inComponent: 0, animated: false)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        pickerView.delegate = self
        pickerView.dataSource = self
        value = 1
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedValueLabel.text = String(rounds[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        label.textColor = UIColor(named: "TimerTextGrey")
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        label.text = String(rounds[row])
        return label
    }
}
