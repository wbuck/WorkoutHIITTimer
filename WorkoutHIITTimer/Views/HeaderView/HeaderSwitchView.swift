//
//  HeaderSwitchView.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-15.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit

@IBDesignable
class HeaderSwitchView: HeaderBase {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var enableSwitch: UISwitch!
    var delegate: HeaderSwitchViewDelegate?
    @IBInspectable
    var title: String? {
        didSet {
            headerLabel.text = title
        }
    }
    
    @IBInspectable
    var isEnabled: Bool = true {
        didSet {
            headerLabel.isEnabled = isEnabled
            enableSwitch.isEnabled = isEnabled
        }
    }
    
    @IBInspectable
    var section: String = String()
    
    var value: Bool {
        get {
            return enableSwitch.isOn
        }
        set {
            enableSwitch.isOn = newValue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibContent()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }
    
    @IBAction func uiSwitchValueChanged(_ sender: UISwitch) {
        delegate?.headerValueChanged(self, value: sender.isOn)
    }
}
