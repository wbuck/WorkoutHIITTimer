//
//  SoundPickerControlView.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-20.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit

@IBDesignable
class SoundPickerControlView: UIView, PickerView, NibFileOwnerLoadable {
    
    @IBOutlet weak var chevronImage: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var selectionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    weak var delegate: PickerControlViewDelegate?
    private var observer: NSKeyValueObservation?
    let sounds = ["Beep", "Bloop", "Space", "Boxing Bell", "Laser", "Sound1", "Sound2", "Sound3"]
    
    var id: Int {
        return self.tag
    }
    
    // Track the state (expanded or collapsed) of
    // the view.
    private(set) var pickerViewState = PickerViewState.collapsed {
        didSet {
            let rotate: Rotate = pickerViewState == .collapsed ?
                .counterClockwise : .clockwise
            rotateArrow(in: rotate)
        }
    }
    
    @IBInspectable
    var text: String? {
        didSet {
            titleLabel.text = text
        }
    }
    
    var separatorIsHidden: Bool = false {
        didSet {
             separatorView.isHidden = separatorIsHidden
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

extension SoundPickerControlView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sounds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectionLabel.text = sounds[row]
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
