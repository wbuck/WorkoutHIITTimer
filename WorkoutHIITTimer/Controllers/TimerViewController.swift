//
//  TimerViewController.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-28.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var quitButton: UIButton!
    @IBOutlet weak var controlsContainerView: UIView!
    @IBOutlet weak var controlsViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var startButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var startButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        drawCircularButton(startStopButton, color: UIColor(named: "TimerOrange"))
        drawCircularButton(resetButton, color: UIColor(named: "TimerWhite"))
        drawCircularButton(quitButton, color: UIColor(named: "TimerWhite"))
    }
    
    private func drawCircularButton(_ button: UIButton, color: UIColor?) {
        button.layer.borderColor = color?.cgColor
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 2
        button.layer.cornerRadius = button.frame.width / 2
        button.layer.masksToBounds = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        if UIDevice.current.orientation.isLandscape {
            self.controlsViewHeightConstraint.constant = 150
            self.startButtonHeightConstraint.constant = 60
            self.startButtonWidthConstraint.constant = 60
            self.startStopButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            self.buttonStackView.layoutIfNeeded()
            self.drawCircularButton(self.startStopButton, color: UIColor(named: "TimerOrange"))
        }
        else {
            self.controlsViewHeightConstraint.constant = 245
            self.startButtonHeightConstraint.constant = 124
            self.startButtonWidthConstraint.constant = 124
            self.startStopButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            self.buttonStackView.layoutIfNeeded()
            self.drawCircularButton(self.startStopButton, color: UIColor(named: "TimerOrange"))
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
