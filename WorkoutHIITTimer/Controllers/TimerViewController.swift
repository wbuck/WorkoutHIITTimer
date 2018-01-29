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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        createCircularButton(startStopButton, color: UIColor(named: "TimerOrange"))
        createCircularButton(resetButton, color: UIColor(named: "TimerWhite"))
        createCircularButton(quitButton, color: UIColor(named: "TimerWhite"))
    }
    
    private func createCircularButton(_ button: UIButton, color: UIColor?, width: CGFloat? = nil) {
        button.layer.borderColor = color?.cgColor
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 2
        button.layer.cornerRadius = width ?? button.frame.width / 2
        button.layer.masksToBounds = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        DispatchQueue.main.async {
            if UIDevice.current.orientation.isLandscape {
                self.controlsViewHeightConstraint.constant = 150
                self.startButtonHeightConstraint.constant = 60
                self.startButtonWidthConstraint.constant = 60
                self.startStopButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
                 self.view.layoutIfNeeded()
                self.createCircularButton(self.startStopButton, color: UIColor(named: "TimerOrange"), width: 60)
            }
            else {
                self.controlsViewHeightConstraint.constant = 245
                self.startButtonHeightConstraint.constant = 124
                self.startButtonWidthConstraint.constant = 124
                self.startStopButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
                 self.view.layoutIfNeeded()
                self.createCircularButton(self.startStopButton, color: UIColor(named: "TimerOrange"), width: 124)
                
            }
           
        }
        //view.layoutIfNeeded()
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
