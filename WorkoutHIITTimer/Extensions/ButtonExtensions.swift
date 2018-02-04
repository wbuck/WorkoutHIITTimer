//
//  ButtonExtensions.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-02-04.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit

public extension UIButton {
    
    func drawAsCircle(backgroundColor: UIColor?, borderWidth: Float, borderColor: UIColor?) {
        self.layer.borderColor = borderColor?.cgColor
        self.backgroundColor = backgroundColor
        self.layer.borderWidth = CGFloat(borderWidth)
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
}

