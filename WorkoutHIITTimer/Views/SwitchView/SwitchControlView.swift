//
//  SwitchControlView.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-23.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit

@IBDesignable
class SwitchControlView: UIView, NibFileOwnerLoadable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var enableSwitch: UISwitch!
    
    @IBInspectable
    var text: String? {
        didSet {
            titleLabel.text = text
        }
    }
    
    @IBInspectable
    var isEnabled: Bool {
        get {
            return enableSwitch.isOn
        }
        set {
            enableSwitch.isOn = newValue
        }
    }
    
    @IBInspectable
    var section: String = String()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        loadNibContent()
    }
}
