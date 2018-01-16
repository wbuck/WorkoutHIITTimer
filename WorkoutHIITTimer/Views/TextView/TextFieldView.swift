//
//  TextFieldView.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-15.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit

@IBDesignable class TextFieldView: UIView, NibFileOwnerLoadable {
    
    var placeHolder: String? {
        didSet {
            guard let text = placeHolder else { return }
            let color = UIColor(named: "TimerFadedGrey") ?? UIColor.flatGray
            inputTextField.attributedPlaceholder =
                NSAttributedString(string: text.lowercased(),
                    attributes: [NSAttributedStringKey.foregroundColor : color])
        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibContent()
    }
}
