//
//  PickerControlView.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-15.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit

@IBDesignable
class TimePickerControlView: UIView, NibFileOwnerLoadable  {
    
    @IBOutlet weak var chevronImage: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var selectionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate: PickerControlViewDelegate?
    private var observer: NSKeyValueObservation?
    
    // Track the state (expanded or collapsed) of
    // the view.
    private(set) var pickerViewState = PickerViewState.collapsed {
        didSet {
            let rotate: Rotate = pickerViewState == .collapsed ?
                .counterClockwise : .clockwise
            rotateArrow(in: rotate)
        }
    }
    
    // Format and display time in label.
    private(set) var time: (Int, Int, Int) = (0, 0, 0) {
        didSet {
            let hour = time.0 < 10 ? "0\(time.0)" : "\(time.0)"
            let minute = time.1 < 10 ? "0\(time.1)" : "\(time.1)"
            let second = time.2 < 10 ? "0\(time.2)" : "\(time.2)"
            selectionLabel.text = "\(hour):\(minute):\(second)"
        }
    }
    
    @IBInspectable
    var text: String? {
        didSet {
            titleLabel.text = text
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
        loadNibContent()
        pickerView.delegate = self
        pickerView.dataSource = self
        observer?.invalidate()
        observer = self.layer.observe(\CALayer.bounds, changeHandler: {
            (layer, _) in
            if Int(layer.frame.height) != self.pickerViewState.rawValue {
                self.pickerViewState = Int(layer.frame.height) > PickerViewState.collapsed.rawValue ?
                    .expanded : .collapsed
            }
        })
    }
    
    deinit {
        print("De init")
    }
    
    private func rotateArrow(in direction: Rotate) {
        // I multiplied the result to ensure the rotation
        // back to its starting position moves ccw.
        let angle = CGFloat(direction.rawValue) * CGFloat.pi * 0.999;
        UIView.animate(withDuration: 0.3) {
            self.chevronImage.transform = self.chevronImage.transform.rotated(by: angle)
        }
    }
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        delegate?.pickerControlViewTapped(self)
    }
}

extension TimePickerControlView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    // Define the columns of the picker view.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            // Hours.
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
