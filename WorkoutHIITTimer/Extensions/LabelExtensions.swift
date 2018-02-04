//
//  LabelExtensions.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-02-04.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit

public extension UILabel {
    
    func roundCorners(backgroundColor: UIColor?, cornerRadius: Float, borderWidth: Float, borderColor: UIColor?) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.layer.masksToBounds = true
        self.layer.borderWidth = CGFloat(borderWidth)
        self.backgroundColor = backgroundColor
        self.layer.borderColor = borderColor?.cgColor
    }
}

