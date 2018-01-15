//
//  UISegmentTableViewCell.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-14.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit

class UISegmentTableViewCell: UITableViewCell, CustomCellActions {
    var isEnabled: Bool = true {
        didSet {
            titleTextLabel.isEnabled = isEnabled
            segmentControl.isEnabled = isEnabled
        }
    }
    
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
    }
    
}
