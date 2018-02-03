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
    
    private let mainMenuSegue = "GoToMainMenu"
    private var warmupTime: AsyncTimer?
    private var restTime: AsyncTimer?
    private var roundTime: AsyncTimer!
    private var coolDownTimer: AsyncTimer?
    private var countDirection: Count!
    private var currentRound: Int = 1
    private var timer: AsyncTimer!
    private var totalTime = 0
    var roundTimer: RoundTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func updateUI() {
        
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
        roundIndicatorLabel.text = "---"
        print("Round timer")
        
    }
    
    
//        private func setupTimers(roundTimer: RoundTimer) {
//            let interval = Int(roundTimer.roundsIntervalInSeconds)
//            print(interval)
//            timer = AsyncTimer(queue: .main, interval: .seconds(1), repeats: true) {
//                self.totalTimer += 1
//                self.timeIndicatorLabel.text = "\(self.formatTime(from: self.totalTimer))"
//                if self.totalTimer == interval {
//                    self.timer?.stop()
//                }
//            }
//        }
    
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
    
    @IBAction func quitButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: mainMenuSegue, sender: self)
    }
}

class TimerControl {
    private var timer: AsyncTimer!
    private(set) var timerType: TimerType
    // Count direction (up or down) of the timer.
    private(set) var timerDirection: Count
    // Total time of timer.
    let timeInterval: TimeInterval
    private(set) var elapsedTimeInSeconds: TimeInterval
    private(set) var remainingTimeInSeconds: TimeInterval
    private(set) var isTimerComplete: Bool
    var delegate: TimerChangedDelegate?
    var timerState: TimerState {
        get {
            if timer.isRunning { return TimerState.running }
            else if timer.isPaused { return TimerState.paused }
            else { return TimerState.stopped }
        }
    }
    
    init(type: TimerType, direction: Count, interval: TimeInterval) {
        timerType = type
        timeInterval = interval
        timerDirection = direction
        elapsedTimeInSeconds = 0
        remainingTimeInSeconds = timeInterval
        isTimerComplete = false
        createTimer()
    }
    
    private func createTimer() {
        switch timerDirection {
        case .up:
            timer = AsyncTimer(queue: .main, interval: .seconds(1), times: Int(timeInterval),
            block: { (value) in
                self.elapsedTimeInSeconds += 1
                self.remainingTimeInSeconds -= 1
                self.delegate?.timerControl(self, elapsedTime: self.elapsedTimeInSeconds, remaining: self.remainingTimeInSeconds)
            }, completion: {
                self.isTimerComplete = true
                self.delegate?.timerControl(self, finalTime: self.elapsedTimeInSeconds)
            })
        case .down:
            timer = AsyncTimer(queue: .main, interval: .seconds(1), times: Int(timeInterval),
                               block: { (value) in
                                self.elapsedTimeInSeconds += 1
                                self.remainingTimeInSeconds -= 1
                                self.delegate?.timerControl(self, elapsedTime: self.remainingTimeInSeconds, remaining: self.elapsedTimeInSeconds)
            }, completion: {
                self.isTimerComplete = true
                self.delegate?.timerControl(self, finalTime: self.remainingTimeInSeconds)
            })
        }
    }
    
    func start() {
        timer.start()
    }
    
    func stop() {
        timer.stop()
    }
    
    func pause() {
        timer.pause()
    }
    
    func resume() {
        timer.resume()
    }
    
    func reset() {
        timer.restart()
    }
}











