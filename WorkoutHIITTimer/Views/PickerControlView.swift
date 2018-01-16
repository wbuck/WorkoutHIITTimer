//
//  PickerControlView.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-15.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit

class PickerControlView: UIView, NibFileOwnerLoadable  {

    
    @IBOutlet weak var chevronImage: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibContent()
        
        chevronImage.transform = chevronImage.transform.rotated(by: .pi / 2)
    }
}
