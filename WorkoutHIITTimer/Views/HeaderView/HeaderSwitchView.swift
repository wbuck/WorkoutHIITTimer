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
    
    @IBInspectable
    var text: String? {
        didSet {
            headerLabel.text = text
        }
    }
    
    @IBInspectable
    var section: String = String()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibContent()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }
}
