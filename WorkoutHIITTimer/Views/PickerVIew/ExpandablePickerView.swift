//
//  ExpandablePickerView.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-20.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit

class ExpandablePickerView: UIView, PickerView, NibFileOwnerLoadable {
    
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var selectedValueLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    weak var delegate: PickerControlViewDelegate?
    private var observer: NSKeyValueObservation?
    
    // Returns the ID of the view.
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
    
    var separatorIsHidden: Bool = false {
        didSet {
            separatorView.isHidden = separatorIsHidden
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }
    
    private func initializeView() {
        loadNibContent()
        
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
            self.arrow.transform = self.arrow.transform.rotated(by: angle)
        }
    }
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        delegate?.pickerControlViewTapped(self)
    }
    
}
