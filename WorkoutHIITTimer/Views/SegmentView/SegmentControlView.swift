//
//  SegmentControlView.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-15.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit

@IBDesignable
class SegmentControlView: UIView, NibFileOwnerLoadable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var segmentView: UISegmentedControl!
    
    @IBInspectable
    var text: String? {
        didSet {
            titleLabel.text = text
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
    @IBAction func segmentViewValueChanged(_ sender: UISegmentedControl) {
    }
}
