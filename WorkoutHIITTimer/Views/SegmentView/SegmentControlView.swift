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
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    @IBInspectable
    var isEnabled: Bool = true {
        didSet {
            titleLabel.isEnabled = isEnabled
            segmentView.isEnabled = isEnabled
        }
    }
    
    @IBInspectable
    var section: String = String.empty
    

    var value: Count {
        get {
            return Count(rawValue: segmentView.selectedSegmentIndex)!
        }
        set {
            segmentView.selectedSegmentIndex = newValue.rawValue
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
}
