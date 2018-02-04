//
//  TimerViewController.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-28.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit

class RoundTimerDisplayViewController: UIViewController {
    
    private let audioPlayer = AudioPlayer()
    private var currentTimerIndex: Int = 0
    private let mainMenuSegue = "GoToMainMenu"
    private var timers = [TimerWrapper]()
    private var firstTimerTickComplete = false
    var roundTimer: RoundTimer!
    private var currentRound: Int = 0 {
        didSet {
            roundIndicatorLabel.text = "\(currentRound)"
        }
    }
    private var totalTimeInSeconds: Int = 0 {
        didSet {
            totalTimeIndicatorLabel.text = totalTimeInSeconds.formatToMinutesAndSeconds()
        }
    }
    private var elapsedTimeInSeconds: Int = 0 {
        didSet {
            timeIndicatorLabel.text = elapsedTimeInSeconds.formatToMinutesAndSeconds()
        }
    }
    private var remainingTimeInSeconds: Int = 0 {
        didSet {
            timeRemainingIndicatorLabel.text = remainingTimeInSeconds.formatToMinutesAndSeconds()
        }
    }
    
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
    @IBOutlet weak var workoutLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var roundTitleLabel: UILabel!
    @IBOutlet weak var roundIndicatorLabel: UILabel!
    @IBOutlet weak var timeIndicatorLabel: UILabel!
    @IBOutlet weak var timeRemainingIndicatorLabel: UILabel!
    @IBOutlet weak var totalTimeIndicatorLabel: UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTimers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startStopButton.drawAsCircle(backgroundColor: UIColor.clear, borderWidth: 2, borderColor: UIColor(named: "TimerOrange"))
        resetButton.drawAsCircle(backgroundColor: UIColor.clear, borderWidth: 2, borderColor: UIColor(named: "TimerWhite"))
        quitButton.drawAsCircle(backgroundColor: UIColor.clear, borderWidth: 2, borderColor: UIColor(named: "TimerWhite"))
        workoutLabel.roundCorners(backgroundColor: UIColor.clear, cornerRadius: 5, borderWidth: 2, borderColor: UIColor.clear)
        navigationController?.isNavigationBarHidden = true
        roundIndicatorLabel.text = "rounds".uppercased()
        currentRound = 0
        updateInterface()
        changeSizeBasedOnOrientation()
    }
    
    private func updateInterface() {
        let timer = timers[currentTimerIndex]
        changeWorkoutLabel(timer)
        if timer.timerDirection == .up {
            elapsedTimeInSeconds = 0
            remainingTimeInSeconds = Int(timer.totalTimeInSeconds)
        } else {
            elapsedTimeInSeconds = Int(timer.totalTimeInSeconds)
            remainingTimeInSeconds = Int(timer.totalTimeInSeconds)
        }
        totalTimeInSeconds = 0
        currentRound = 0
        startStopButton.setTitle("START", for: .normal)
    }
    
    private func changeWorkoutLabel(_ timer: TimerWrapper) {
        workoutLabel.text = timer.displayName
        workoutLabel.layer.borderColor = timer.borderColor.cgColor
        workoutLabel.textColor = timer.textColor
    }
    
    // Create all of the required timers.
    private func createTimers() {
        timers.removeAll()
        let direction = roundTimer.countDirection
        if roundTimer.warmupTimerEnabled {
            let warmup = TimerWrapper(type: .warmupTimer, name: "Warmup",
                                      direction: direction, interval: roundTimer.warmupIntervalInSeconds)
            warmup.delegate = self
            timers.append(warmup)
        }
        for _ in 1...roundTimer.rounds {
            let round = TimerWrapper(type: .roundTimer, name: "Workout",
                                     direction: direction, interval: roundTimer.roundsIntervalInSeconds)
            round.delegate = self
            timers.append(round)
            if roundTimer.restTimerEnabled {
                let rest = TimerWrapper(type: .restTimer, name: "Rest",
                                        direction: direction, interval: roundTimer.restIntervalInSeconds)
                rest.delegate = self
                timers.append(rest)
            }
        }
        if roundTimer.coolDownTimerEnabled {
            let coolDown = TimerWrapper(type: .coolDownTimer, name: "Cooldown",
                                        direction: direction, interval: roundTimer.coolDownIntervalInSeconds)
            coolDown.delegate = self
            timers.append(coolDown)
        }
    }

    private func resizeStartButton(new size: CGFloat, font ofSize: CGFloat){
        startButtonHeightConstraint.constant = size
        startButtonWidthConstraint.constant = size
        startStopButton.titleLabel?.font = UIFont.systemFont(ofSize: ofSize)
        buttonStackView.layoutIfNeeded()
    }
    
    private func resizeWorkoutLabel(new size: CGSize, font ofSize: CGFloat, topPosition: CGFloat = 30) {
        workoutLabelWidthConstraint.constant = size.width
        workoutLabelHeightConstraint.constant = size.height
        workoutLabelTopConstraint.constant = topPosition
        workoutLabel.font = UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.semibold)
        workoutLabel.layoutIfNeeded()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        changeSizeBasedOnOrientation()
    }
    
    // Handle orientation changes.
    private func changeSizeBasedOnOrientation() {
        if UIDevice.current.orientation.isLandscape {
            resizeStartButton(new: 70, font: 13)
            startStopButton.drawAsCircle(backgroundColor: UIColor.clear, borderWidth: 2, borderColor: UIColor(named: "TimerOrange"))
            buttonStackView.spacing = 60
            resizeWorkoutLabel(new: CGSize(width: 135, height: 38), font: 18, topPosition: 20)
        }
        else {
            resizeStartButton(new: 124, font: 20)
            startStopButton.drawAsCircle(backgroundColor: UIColor.clear, borderWidth: 2, borderColor: UIColor(named: "TimerOrange"))
            buttonStackView.spacing = 40
            resizeWorkoutLabel(new: CGSize(width: 160, height: 46), font: 24, topPosition: 40)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func startStopButtonPressed(_ sender: UIButton) {
        let timer = timers[currentTimerIndex]
        if timer.timerState == .running {
            timer.pause()
            sender.setTitle(TimerFunctions.resume.rawValue, for: .normal)
        }
        else if timer.timerState == .paused {
            timer.resume()
            sender.setTitle(TimerFunctions.pause.rawValue, for: .normal)
        }
        else {
            timer.start()
            sender.setTitle(TimerFunctions.pause.rawValue, for: .normal)
        }
        
    }
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        timers[currentTimerIndex].stop()
        currentTimerIndex = 0
        firstTimerTickComplete = false
        createTimers()
        updateInterface()
    }
    
    @IBAction func quitButtonPressed(_ sender: UIButton) {
        timers[currentTimerIndex].stop()
        performSegue(withIdentifier: mainMenuSegue, sender: self)
    }
}

extension RoundTimerDisplayViewController: TimerChangedDelegate {
    
    func timerStarted(_ timerControl: TimerWrapper) {
        if timerControl.timerType == .roundTimer {
            currentRound += 1
        }
        // Play timer starting sound if enabled.
        if roundTimer.startAlertEnabled {
            guard let sound = roundTimer.startAlertSound else { return }
            audioPlayer.playSound(sound, "wav")
        }
    }
    
    func timerValueChanged(_ timerControl: TimerWrapper, elapsedTimeInSeconds: TimeInterval, totalTimeInSeconds: TimeInterval) {
        if timerControl.timerDirection == .up {
            self.elapsedTimeInSeconds = Int(elapsedTimeInSeconds)
            remainingTimeInSeconds = Int(totalTimeInSeconds - elapsedTimeInSeconds)
            self.totalTimeInSeconds += 1
        } else {
            // Add 1 to the display value so that 0 is not
            // shown as the last value for a timer.
            let remainingTime = Int(totalTimeInSeconds - elapsedTimeInSeconds) + 1
            self.elapsedTimeInSeconds = remainingTime
            remainingTimeInSeconds = remainingTime
            // Prevents to total time indicator from incrementing
            // before the other time indicators increment.
            if firstTimerTickComplete {
                self.totalTimeInSeconds += 1
            }
            firstTimerTickComplete = true
        }
        // Play ending beep if enabled.
        if remainingTimeInSeconds <= 3 && timerControl.timerType != .coolDownTimer &&
            roundTimer.endAlertEnabled {
            audioPlayer.playSound("End Beep", "wav")
        }
    }
    
    func timerComplete(_ timerControl: TimerWrapper) {
        // Queue up the next timer to display.
        if let index = timers.index(0, offsetBy: currentTimerIndex + 1, limitedBy: timers.endIndex - 1) {
            currentTimerIndex = index
            let nextTimer = timers[currentTimerIndex]
            changeWorkoutLabel(nextTimer)
            nextTimer.start()
        } else if timerControl.timerDirection == .down {
            // Setting the display to 0 when the final timer expires.
            // This fixes the issue where 1 second is left showing
            // on the display when the last timer finishes.
            elapsedTimeInSeconds = 0
            remainingTimeInSeconds = 0
            totalTimeInSeconds += 1
        }
    }
}













