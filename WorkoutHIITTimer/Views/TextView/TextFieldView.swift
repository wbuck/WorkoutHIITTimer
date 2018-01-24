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
            let color = UIColor(named: "TimerFadedGrey") ?? UIColor.gray
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
    
    @IBInspectable
    var isEnabled: Bool = true {
        didSet {
            titleLabel.isEnabled = isEnabled
            inputTextField.isEnabled = isEnabled
        }
    }
    
    @IBInspectable
    var section: String = String()
    
    var value: String? {
        get {
            return inputTextField.text
        }
        set {
            inputTextField.text = newValue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    private func initialize() {
        loadNibContent()
        inputTextField.returnKeyType = .done
        inputTextField.delegate = self
    }
}

extension TextFieldView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
