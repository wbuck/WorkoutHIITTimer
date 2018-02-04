//
//  ButtonExtensions.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-02-04.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit

public extension UIButton {
    
    func circleButton(backgroundColor: UIColor?, borderWidth: Float, borderColor: UIColor?) {
        self.layer.borderColor = borderColor?.cgColor
        self.backgroundColor = backgroundColor
        self.layer.borderWidth = CGFloat(borderWidth)
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
}

/*
private func drawCircularButton(_ button: UIButton, backgroundColor: UIColor?, borderWidth: Float, borderColor: UIColor?) {
    button.layer.borderColor = borderColor?.cgColor
    button.backgroundColor = backgroundColor
    button.layer.borderWidth = CGFloat(borderWidth)
    button.layer.cornerRadius = button.frame.width / 2
    button.layer.masksToBounds = true
}
*/
