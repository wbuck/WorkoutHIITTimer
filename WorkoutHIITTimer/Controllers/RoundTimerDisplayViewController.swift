//
//  TimerViewController.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-28.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit
import AsyncTimer

class RoundTimerDisplayViewController: UIViewController {
    
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var quitButton: UIButton!
    @IBOutlet weak var controlsContainerView: UIView!
    @IBOutlet weak var startButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var startButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var workoutLabel: UILabel!
    @IBOutlet weak var workoutLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var workoutLabelWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var roundTitleLabel: UILabel!
    @IBOutlet weak var roundIndicatorLabel: UILabel!
    @IBOutlet weak var timeIndicatorLabel: UILabel!
    
    var asyncTimers = [AsyncTimer]()
    let mainMenuSegue = "GoToMainMenu"
    var roundTimer: RoundTimer!
    
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
        constructTimer()
    }
    
    private func constructTimer() {
        
        roundIndicatorLabel.text = "rounds".uppercased()
        roundIndicatorLabel.text = "000"
        setupTimers(roundTimer: roundTimer)
        print("Round timer")
        
    }
    var timer: AsyncTimer?
    var totalTimer = 0
    
    private func setupTimers(roundTimer: RoundTimer) {
        let interval = Int(roundTimer.roundsIntervalInSeconds)
        print(interval)
        timer = AsyncTimer(queue: .main, interval: .seconds(1), repeats: true) {
            self.totalTimer += 1
            self.timeIndicatorLabel.text = "\(self.formatTime(from: self.totalTimer))"
            if self.totalTimer == interval {
                self.timer?.stop()
            }
        }
        
        /*
         timer = AsyncTimer(queue: .main,
         interval: .seconds(1),
         times: 20,
         block: {
         (value) in
         self.timeIndicatorLabel.text = "00:\(value)"
         }) {
         print("Complete")
         }
         
         timer!.start()
         */
    }
    
    private func formatTime(from seconds: Int) -> String {
        let time = (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
        let hour = time.0 < 10 ? "0\(time.0)" : "\(time.0)"
        let minute = time.1 < 10 ? "0\(time.1)" : "\(time.1)"
        let second = time.2 < 10 ? "0\(time.2)" : "\(time.2)"
        return "\(hour):\(minute):\(second)"
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
    
    private func resizeWorkoutLabel(new size: CGSize, font ofSize: CGFloat) {
        workoutLabelWidthConstraint.constant = size.width
        workoutLabelHeightConstraint.constant = size.height
        workoutLabel.font = UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.semibold)
        workoutLabel.layoutIfNeeded()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        if UIDevice.current.orientation.isLandscape {
            resizeStartButton(new: 60, font: 13)
            drawCircularButton(startStopButton, color: UIColor(named: "TimerOrange"))
            buttonStackView.spacing = 60
            resizeWorkoutLabel(new: CGSize(width: 135, height: 38), font: 18)
        }
        else {
            resizeStartButton(new: 124, font: 20)
            drawCircularButton(startStopButton, color: UIColor(named: "TimerOrange"))
            buttonStackView.spacing = 40
            resizeWorkoutLabel(new: CGSize(width: 147, height: 46), font: 24)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func startStopButtonPressed(_ sender: UIButton) {
        if timer == nil { return }
        if (timer?.isStopped)! {
            timer?.start()
            sender.setTitle("STOP", for: .normal)
        }
        else if (timer?.isPaused)! {
            timer?.resume()
            sender.setTitle("STOP", for: .normal)
        }
        else {
            timer?.pause()
            sender.setTitle("START", for: .normal)
        }
        
    }
    //myButton.setTitle("Pressed", forState: UIControlState.Normal)
    
    
    @IBAction func quitButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: mainMenuSegue, sender: self)
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
