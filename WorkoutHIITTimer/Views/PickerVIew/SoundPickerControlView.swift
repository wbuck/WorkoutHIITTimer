//
//  SoundPickerControlView.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-20.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit

@IBDesignable
class SoundPickerControlView: ExpandablePickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let sounds = ["Beep", "Bloop", "Space", "Boxing Bell", "Laser", "Sound1", "Sound2", "Sound3"]
    
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
        value = sounds[0]
    }
    
    var value: String = String() {
        didSet {
            guard let index = sounds.index(of: value) else { return }
            pickerView.selectRow(index, inComponent: 0, animated: false)
            selectedValueLabel.text = value
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sounds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedValueLabel.text = sounds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        label.textColor = UIColor(named: "TimerTextGrey")
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        label.text = sounds[row]
        return label
    }
}


