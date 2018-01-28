//
//  UIButtonExtensions.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-28.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit

extension UIButton {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
//    @IBInspectable
//    var borderColor: CGColor {
//        get {
//            return layer.borderColor ?? UIColor.clear.cgColor
//        }
//        set {
//            layer.borderColor = newValue
//        }
//    }
}
