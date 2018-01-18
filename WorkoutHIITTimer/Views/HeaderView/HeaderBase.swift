//
//  HeaderBase.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-18.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit


class HeaderBase: UIView, NibFileOwnerLoadable {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createDropShadow()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createDropShadow()
    }
    
    // Create drop shadow.
    private func createDropShadow() {
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 3, height: 5)
        self.layer.shadowRadius = 8
    }
}
