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
    @IBOutlet weak var startButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var startButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var workoutLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        drawCircularButton(startStopButton, color: UIColor(named: "TimerOrange"))
        drawCircularButton(resetButton, color: UIColor(named: "TimerWhite"))
        drawCircularButton(quitButton, color: UIColor(named: "TimerWhite"))
        workoutLabel.layer.cornerRadius = 5
        workoutLabel.layer.masksToBounds = true
        navigationController?.isNavigationBarHidden = true
    }
    
    private func drawCircularButton(_ button: UIButton, color: UIColor?) {
        button.layer.borderColor = color?.cgColor
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 2
        button.layer.cornerRadius = button.frame.width / 2
        button.layer.masksToBounds = true
    }
    
    private func resizeStartButton(new size: CGFloat, font ofSize: CGFloat){
        startButtonHeightConstraint.constant = size
        startButtonWidthConstraint.constant = size
        startStopButton.titleLabel?.font = UIFont.systemFont(ofSize: ofSize)
        buttonStackView.layoutIfNeeded()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        if UIDevice.current.orientation.isLandscape {
            resizeStartButton(new: 60, font: 13)
            drawCircularButton(startStopButton, color: UIColor(named: "TimerOrange"))
            buttonStackView.spacing = 60
        }
        else {
            resizeStartButton(new: 124, font: 20)
            drawCircularButton(startStopButton, color: UIColor(named: "TimerOrange"))
            buttonStackView.spacing = 40
            
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
