//
//  TextFieldView.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-15.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit

@IBDesignable
class TextFieldView: UIView, NibFileOwnerLoadable {
    

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBInspectable
    var placeHolder: String? {
        didSet {
            guard let text = placeHolder else { return }
            let color = UIColor(named: "TimerFadedGrey") ?? UIColor.flatGray
            inputTextField.attributedPlaceholder =
                NSAttributedString(string: text,
                                   attributes: [NSAttributedStringKey.foregroundColor : color])
        }
    }
    
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
}
